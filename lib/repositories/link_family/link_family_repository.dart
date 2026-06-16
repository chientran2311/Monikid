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

  /// Lean members stream (child app) — no enrichment, no user-doc reads.
  Stream<List<FamilyMemberModel>> watchFamilyMembers(String familyId);

  /// Enriched members stream (parent app) — populates display_name/avatar_url
  /// from users/{uid}. Requires parent read permission on family member docs.
  Stream<List<FamilyMemberModel>> watchFamilyMembersEnriched(String familyId);

  /// Enriched one-shot members fetch (parent app).
  Future<List<FamilyMemberModel>> getFamilyMembersOnce(String familyId);

  Future<void> joinFamily({
    required String familyId,
    required String userId,
  });

  Future<void> refreshInviteCode(String familyId);

  /// Returns the existing invite code if present, otherwise generates and
  /// persists a new one. Idempotent — safe to call multiple times.
  Future<String> ensureInviteCode(String familyId);

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
          tx.update(userRef, {
            'family_id': familyId,
            'updated_at': FieldValue.serverTimestamp(),
          });
          return;
        }

        final userRole = userDoc.data()?['role'] as String? ?? 'child';

        tx.update(familyRef, {
          'members': FieldValue.arrayUnion([
            {
              'user_id': userId,
              'family_role': 'member',
              'user_role': userRole,
            }
          ]),
          'updated_at': FieldValue.serverTimestamp(),
        });
        tx.update(userRef, {
          'family_id': familyId,
          'updated_at': FieldValue.serverTimestamp(),
        });
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

      // host_display_name must be non-empty — the Firestore rule enforces
      // size() > 0 so the child app always has a host name to render. Fall back
      // to the email local-part, then a generic label, for blank profiles.
      final rawName = (userData['display_name'] as String?)?.trim() ?? '';
      final email = userData['email'] as String? ?? '';
      final emailName =
          email.contains('@') ? email.split('@').first.trim() : '';
      final displayName = rawName.isNotEmpty
          ? rawName
          : (emailName.isNotEmpty ? emailName : 'Parent');
      final avatarUrl = userData['avatar_url'] as String? ?? '';
      _logger.d('createFamily: resolvedHostName="$displayName" '
          'rawName="$rawName" hasAvatar=${avatarUrl.isNotEmpty}');

      final familyRef = _firestore.collection('families').doc();
      final userRef = _firestore.collection('users').doc(ownerUid);

      // Step 1: create the family + link the host. invite_code stays null until
      // step 2 — the security rules require the requester to already have a
      // family_id before an invite_codes doc can be written.
      // Write-only multi-doc atomic write → WriteBatch, not a transaction.
      // A write-only runTransaction (no tx.get) hangs forever in FlutterFire.
      _logger.d('createFamily: step 1 — writing family=${familyRef.id}');
      final batch = _firestore.batch();
      batch.set(familyRef, {
        'family_id': familyRef.id,
      
        'host_display_name': displayName,
        'host_avatar_url': avatarUrl,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
        'members': [
          {
            'user_id': ownerUid,
            'family_role': 'host',
            'user_role': 'parent',
          }
        ],
      });
      batch.update(userRef, {
        'family_id': familyRef.id,
        'updated_at': FieldValue.serverTimestamp(),
      });
      await batch.commit();
      _logger.i('createFamily: step 1 committed. family=${familyRef.id}');

      // Step 2: generate the invite code now that the host has a family_id.
      // A failure here leaves a valid family with a null invite_code —
      // refreshInviteCode can create one later. Do NOT roll back the family.
      try {
        await _createInviteCode(familyRef.id);
      } catch (error, stackTrace) {
        _logger.e(
          'createFamily: step 2 invite code creation failed. '
          'family=${familyRef.id} (family still valid)',
          error: error,
          stackTrace: stackTrace,
        );
      }

      _logger.d('createFamily: re-reading family doc. family=${familyRef.id}');
      final doc = await familyRef.get();
      _logger.i('createFamily: success. family=${familyRef.id} '
          'exists=${doc.exists}');
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

  /// Generates a fresh invite code and links it to the family.
  /// Caller must ensure the requester already has family_id == [familyId].
  Future<String> _createInviteCode(String familyId) async {
    _logger.d('_createInviteCode: familyId=$familyId');
    final code = await _generateUniqueCode();
    _logger.d('_createInviteCode: generated code=$code, writing batch.');
    final codeRef = _firestore.collection('invite_codes').doc(code);
    final familyRef = _firestore.collection('families').doc(familyId);

    // Write-only multi-doc atomic write → WriteBatch, not a transaction.
    // A write-only runTransaction (no tx.get) hangs forever in FlutterFire.
    final batch = _firestore.batch();
    // set() with merge:false — fails atomically if code already exists.
    batch.set(
      codeRef,
      {
        'invite_code': code,
        'family_id': familyId,
        'created_at': FieldValue.serverTimestamp(),
        'expired_at': Timestamp.fromDate(
          DateTime.now().add(const Duration(days: _inviteCodeTtlDays)),
        ),
      },
      SetOptions(merge: false),
    );
    batch.update(familyRef, {
      'invite_code': code,
      'updated_at': FieldValue.serverTimestamp(),
    });
    await batch.commit();
    _logger.i('_createInviteCode: success. familyId=$familyId code=$code');
    return code;
  }

  @override
  Future<String> ensureInviteCode(String familyId) async {
    _logger.d('ensureInviteCode: familyId=$familyId');
    try {
      final doc =
          await _firestore.collection('families').doc(familyId).get();
      if (!doc.exists) {
        throw Exception(
          'ensureInviteCode: family not found. familyId=$familyId',
        );
      }
      final existing = doc.data()?['invite_code'] as String?;
      if (existing != null && existing.isNotEmpty) {
        _logger.i('ensureInviteCode: existing code found. familyId=$familyId');
        return existing;
      }
      _logger.i('ensureInviteCode: no code found, generating. familyId=$familyId');
      return await _createInviteCode(familyId);
    } catch (error, stackTrace) {
      _logger.e(
        'ensureInviteCode failed. familyId=$familyId',
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
    // Lean stream (child app) — members are embedded, 0 extra reads per update.
    // No enrichment: child has no permission to read other members' user docs.
    return _firestore
        .collection('families')
        .doc(familyId)
        .snapshots()
        .map((doc) => _extractMembers(doc.data(), familyId));
  }

  @override
  Stream<List<FamilyMemberModel>> watchFamilyMembersEnriched(
    String familyId,
  ) {
    // Enriched stream (parent app) — reads each member's user doc for name/avatar.
    return _firestore
        .collection('families')
        .doc(familyId)
        .snapshots()
        .asyncMap((doc) => _enrichMembers(_extractMembers(doc.data(), familyId)));
  }

  @override
  Future<List<FamilyMemberModel>> getFamilyMembersOnce(
    String familyId,
  ) async {
    try {
      final doc =
          await _firestore.collection('families').doc(familyId).get();
      return _enrichMembers(_extractMembers(doc.data(), familyId));
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

  /// Populates display_name/avatar_url from users/{uid} for the parent app.
  /// A single failed user-doc read degrades to the lean member (empty name)
  /// rather than failing the whole list.
  Future<FamilyMemberModel> _enrichMember(FamilyMemberModel member) async {
    try {
      final doc =
          await _firestore.collection('users').doc(member.uid).get();
      final data = doc.data();
      return member.copyWith(
        displayName: (data?['display_name'] as String?)?.trim() ?? '',
        avatarUrl: data?['avatar_url'] as String?,
      );
    } catch (error, stackTrace) {
      _logger.w(
        '_enrichMember failed, using lean member. uid=${member.uid}',
        error: error,
        stackTrace: stackTrace,
      );
      return member;
    }
  }

  Future<List<FamilyMemberModel>> _enrichMembers(
    List<FamilyMemberModel> lean,
  ) =>
      Future.wait(lean.map(_enrichMember));

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
            'invite_code': newCode,
            'family_id': familyId,
            'created_at': FieldValue.serverTimestamp(),
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
        tx.update(userRef, {
          'family_id': FieldValue.delete(),
          'updated_at': FieldValue.serverTimestamp(),
        });
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
    _logger.d('_generateUniqueCode: start.');
    for (var i = 0; i < _maxRetries; i++) {
      final code = FamilyCodeUtil.generate();
      _logger.d('_generateUniqueCode: attempt ${i + 1}, checking code=$code.');
      final existing =
          await _firestore.collection('invite_codes').doc(code).get();
      if (!existing.exists) {
        _logger.d('_generateUniqueCode: code=$code is free.');
        return code;
      }
      _logger.w(
        '_generateUniqueCode: collision on attempt ${i + 1}. code=$code',
      );
    }
    _logger.w('_generateUniqueCode: exhausted retries, returning last code.');
    return FamilyCodeUtil.generate();
  }
}

@riverpod
LinkFamilyRepository linkFamilyRepository(Ref ref) {
  return getIt<LinkFamilyRepository>();
}
