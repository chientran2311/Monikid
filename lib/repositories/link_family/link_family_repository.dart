import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/utils/family_code_util.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/models/entities/link_family/family_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'link_family_repository.g.dart';

// Invite codes are valid for 7 days from creation.
const _inviteCodeTtlDays = 7;

abstract class LinkFamilyRepository {
  Future<FamilyModel?> createFamily({
    required String ownerUid,
  });

  Future<FamilyModel?> getFamilyByInviteCode(String inviteCode);

  Future<FamilyModel?> getFamilyById(String familyId);

  Stream<List<FamilyMemberModel>> watchFamilyMembers(String familyId);

  Future<List<FamilyMemberModel>> getFamilyMembersOnce(String familyId);

  Future<void> joinFamily({
    required String familyId,
    required String userId,
  });

  Future<void> refreshInviteCode(String familyId);

  Future<bool> isUserAlreadyInFamily(String uid);

  Future<void> removeMember({
    required String familyId,
    required String memberUid,
  });
}

class LinkFamilyRepositoryImpl implements LinkFamilyRepository {
  LinkFamilyRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  static const _maxRetries = 3;
  static const _maxMembers = 5;

  @override
  Future<FamilyModel?> getFamilyByInviteCode(String inviteCode) async {
    final code = inviteCode.trim().toUpperCase();
    if (!RegExp(r'^[A-Z0-9]{6}$').hasMatch(code)) {
      _logger.w('getFamilyByInviteCode: invalid format code=$code');
      return null;
    }

    try {
      _logger.d('getFamilyByInviteCode: code=$code');
      // Use invite_codes index for O(1) lookup + expiry check — no Firestore index needed.
      final codeDoc =
          await _firestore.collection('invite_codes').doc(code).get();
      if (!codeDoc.exists) {
        _logger.w('getFamilyByInviteCode: code not found. code=$code');
        return null;
      }

      final expiredAtRaw = codeDoc.data()?['expired_at'];
      if (expiredAtRaw != null) {
        final expiredAt = (expiredAtRaw as Timestamp).toDate();
        if (DateTime.now().isAfter(expiredAt)) {
          _logger.w(
            'getFamilyByInviteCode: code expired. code=$code expiredAt=$expiredAt',
          );
          return null;
        }
      }

      final familyId = codeDoc.data()?['family_id'] as String?;
      if (familyId == null || familyId.isEmpty) {
        _logger.w('getFamilyByInviteCode: missing family_id. code=$code');
        return null;
      }

      final familyDoc =
          await _firestore.collection('families').doc(familyId).get();
      if (!familyDoc.exists) {
        _logger.w(
          'getFamilyByInviteCode: family not found. familyId=$familyId',
        );
        return null;
      }

      _logger.i('getFamilyByInviteCode: found family=$familyId');
      return FamilyModel.fromFirestore(familyDoc);
    } catch (error, stackTrace) {
      _logger.e(
        'getFamilyByInviteCode failed. code=$code',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<bool> isUserAlreadyInFamily(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        _logger.w('isUserAlreadyInFamily: user not found. uid=$uid');
        return false;
      }
      final familyId = doc.data()?['family_id'] as String?;
      return familyId != null && familyId.isNotEmpty;
    } catch (error, stackTrace) {
      _logger.e(
        'isUserAlreadyInFamily failed. uid=$uid',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> joinFamily({
    required String familyId,
    required String userId,
  }) async {
    _logger.d('joinFamily: familyId=$familyId userId=$userId');
    try {
      final familyRef = _firestore.collection('families').doc(familyId);
      final userRef = _firestore.collection('users').doc(userId);

      await _firestore.runTransaction((tx) async {
        // All reads before all writes — Firestore transaction requirement.
        final familyDoc = await tx.get(familyRef);
        final userDoc = await tx.get(userRef);

        if (!familyDoc.exists) {
          throw Exception('Family does not exist. familyId=$familyId');
        }
        if (!userDoc.exists) {
          throw Exception('User does not exist. userId=$userId');
        }

        final currentFamilyId =
            userDoc.data()?['family_id'] as String?;
        if (currentFamilyId != null && currentFamilyId.isNotEmpty) {
          throw Exception(
            'User already belongs to a family. userId=$userId',
          );
        }

        // Atomic member count check against embedded array — no race condition.
        final members =
            (familyDoc.data()!['members'] as List<dynamic>? ?? [])
                .cast<Map<String, dynamic>>();
        if (members.length >= _maxMembers) {
          throw Exception(
            'Family is full (max $_maxMembers members). familyId=$familyId',
          );
        }

        final alreadyMember = members.any((m) => m['user_id'] == userId);
        if (alreadyMember) {
          // Edge case: member doc exists but user.family_id was cleared — restore.
          tx.update(userRef, {'family_id': familyId});
          return;
        }

        final displayName =
            userDoc.data()?['display_name'] as String? ?? '';
        final avatarUrl = userDoc.data()?['avatar_url'] as String?;
        final userRole = userDoc.data()?['role'] as String? ?? 'child';

        tx.update(familyRef, {
          'members': FieldValue.arrayUnion([
            {
              'user_id': userId,
              'role': 'member',
              'user_role': userRole,
              'display_name': displayName,
              'avatar_url': avatarUrl,
            }
          ]),
          'updated_at': FieldValue.serverTimestamp(),
        });
        tx.update(userRef, {'family_id': familyId});
      });

      _logger.i('joinFamily: success. familyId=$familyId userId=$userId');
    } catch (error, stackTrace) {
      _logger.e(
        'joinFamily failed. familyId=$familyId userId=$userId',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<FamilyModel?> createFamily({required String ownerUid}) async {
    _logger.d('createFamily: ownerUid=$ownerUid');
    try {
      final userSnap =
          await _firestore.collection('users').doc(ownerUid).get();
      if (!userSnap.exists) {
        throw Exception('createFamily: user not found. uid=$ownerUid');
      }

      final userData = userSnap.data()!;
      if (userData['role'] != 'parent') {
        throw Exception(
          'createFamily: user role=${userData['role']}, expected parent',
        );
      }
      final existingFamilyId = userData['family_id'];
      if (existingFamilyId is String && existingFamilyId.isNotEmpty) {
        throw Exception(
          'createFamily: user already in family=$existingFamilyId',
        );
      }

      final displayName = userData['display_name'] as String? ?? '';
      final avatarUrl = userData['avatar_url'] as String?;

      final familyRef = _firestore.collection('families').doc();
      final userRef = _firestore.collection('users').doc(ownerUid);
      final inviteCode = await _generateUniqueCode();

      _logger.d(
        'createFamily: writing family=${familyRef.id} code=$inviteCode',
      );

      await _firestore.runTransaction((tx) async {
        final codeRef =
            _firestore.collection('invite_codes').doc(inviteCode);
        // set() with merge:false — fails atomically if code already exists.
        tx.set(
          codeRef,
          {
            'family_id': familyRef.id,
            'expired_at': Timestamp.fromDate(
              DateTime.now().add(const Duration(days: _inviteCodeTtlDays)),
            ),
          },
          SetOptions(merge: false),
        );

        tx.set(familyRef, {
          'family_id': familyRef.id,
          'invite_code': inviteCode,
          'created_at': FieldValue.serverTimestamp(),
          'updated_at': FieldValue.serverTimestamp(),
          'members': [
            {
              'user_id': ownerUid,
              'role': 'owner',
              'user_role': 'parent',
              'display_name': displayName,
              'avatar_url': avatarUrl,
            }
          ],
        });

        tx.update(userRef, {'family_id': familyRef.id});
      });

      _logger.i('createFamily: success. family=${familyRef.id}');
      final doc = await familyRef.get();
      return FamilyModel.fromFirestore(doc);
    } catch (error, stackTrace) {
      _logger.e(
        'createFamily failed. ownerUid=$ownerUid',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<FamilyModel?> getFamilyById(String familyId) async {
    try {
      _logger.d('getFamilyById: familyId=$familyId');
      final doc =
          await _firestore.collection('families').doc(familyId).get();
      if (!doc.exists) return null;
      return FamilyModel.fromFirestore(doc);
    } catch (error, stackTrace) {
      _logger.e(
        'getFamilyById failed. familyId=$familyId',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Stream<List<FamilyMemberModel>> watchFamilyMembers(String familyId) {
    // Stream the family document — members are embedded, so 0 extra reads per update.
    return _firestore
        .collection('families')
        .doc(familyId)
        .snapshots()
        .map((doc) => _extractMembers(doc.data(), familyId));
  }

  @override
  Future<List<FamilyMemberModel>> getFamilyMembersOnce(
    String familyId,
  ) async {
    try {
      final doc =
          await _firestore.collection('families').doc(familyId).get();
      return _extractMembers(doc.data(), familyId);
    } catch (error, stackTrace) {
      _logger.e(
        'getFamilyMembersOnce failed. familyId=$familyId',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  List<FamilyMemberModel> _extractMembers(
    Map<String, dynamic>? data,
    String familyId,
  ) {
    if (data == null) return [];
    final raw = (data['members'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    return raw.map(FamilyMemberModel.fromMap).toList();
  }

  @override
  Future<void> refreshInviteCode(String familyId) async {
    _logger.d('refreshInviteCode: familyId=$familyId');
    try {
      final newCode = await _generateUniqueCode();
      final familyRef = _firestore.collection('families').doc(familyId);
      final codeRef =
          _firestore.collection('invite_codes').doc(newCode);

      await _firestore.runTransaction((tx) async {
        final familyDoc = await tx.get(familyRef);
        if (!familyDoc.exists) {
          throw Exception('Family not found. familyId=$familyId');
        }

        final oldCode =
            familyDoc.data()?['invite_code'] as String?;
        if (oldCode != null && oldCode.isNotEmpty) {
          tx.delete(_firestore.collection('invite_codes').doc(oldCode));
        }

        tx.set(
          codeRef,
          {
            'family_id': familyId,
            'expired_at': Timestamp.fromDate(
              DateTime.now().add(const Duration(days: _inviteCodeTtlDays)),
            ),
          },
          SetOptions(merge: false),
        );
        tx.update(familyRef, {
          'invite_code': newCode,
          'updated_at': FieldValue.serverTimestamp(),
        });
      });

      _logger.i(
        'refreshInviteCode: success. familyId=$familyId newCode=$newCode',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'refreshInviteCode failed. familyId=$familyId',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> removeMember({
    required String familyId,
    required String memberUid,
  }) async {
    _logger.d('removeMember: familyId=$familyId memberUid=$memberUid');
    try {
      final familyRef = _firestore.collection('families').doc(familyId);
      final userRef = _firestore.collection('users').doc(memberUid);

      await _firestore.runTransaction((tx) async {
        final familyDoc = await tx.get(familyRef);
        if (!familyDoc.exists) {
          throw Exception('Family not found. familyId=$familyId');
        }

        final members =
            (familyDoc.data()!['members'] as List<dynamic>? ?? [])
                .cast<Map<String, dynamic>>();
        // Find the exact map stored in Firestore for arrayRemove deep-equality match.
        final memberMap = members.firstWhere(
          (m) => m['user_id'] == memberUid,
          orElse: () => throw Exception(
            'Member not found. memberUid=$memberUid familyId=$familyId',
          ),
        );

        tx.update(familyRef, {
          'members': FieldValue.arrayRemove([memberMap]),
          'updated_at': FieldValue.serverTimestamp(),
        });
        tx.update(userRef, {'family_id': FieldValue.delete()});
      });

      _logger.i(
        'removeMember: success. familyId=$familyId memberUid=$memberUid',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'removeMember failed. familyId=$familyId memberUid=$memberUid',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Generates a unique 6-char alphanumeric invite code.
  /// Pre-checks [_maxRetries] times; relies on the transaction's set(merge:false)
  /// as the final atomicity guarantee.
  Future<String> _generateUniqueCode() async {
    for (var i = 0; i < _maxRetries; i++) {
      final code = FamilyCodeUtil.generate();
      final existing =
          await _firestore.collection('invite_codes').doc(code).get();
      if (!existing.exists) return code;
      _logger.w(
        '_generateUniqueCode: collision on attempt ${i + 1}. code=$code',
      );
    }
    return FamilyCodeUtil.generate();
  }
}

@riverpod
LinkFamilyRepository linkFamilyRepository(Ref ref) {
  return getIt<LinkFamilyRepository>();
}
