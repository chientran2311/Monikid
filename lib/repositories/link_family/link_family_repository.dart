import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/link_family/family_member_model.dart';
import 'package:monikid/models/entities/link_family/family_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'link_family_repository.g.dart';

abstract class LinkFamilyRepository {
   Future<FamilyModel?> getFamilyByInviteCode(String inviteCode);

  Future<FamilyModel?> getFamilyById(String familyId);

  Stream<List<FamilyMemberModel>> watchFamilyMembers(String familyId);

  Future<void> joinFamily({
    required String familyId,
    required String childId,
    required String childName,
    String? avatarUrl,
  });

  Future<void> refreshInviteCode(String familyId);

  Future<bool> isUserAlreadyInFamily(String uid);

  Future<void> removeChild({
    required String familyId,
    required String childId,
  });
}


class LinkFamilyRepositoryImpl implements LinkFamilyRepository {
  LinkFamilyRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  @override
  Future<FamilyModel?> getFamilyByInviteCode(String inviteCode) async {
    final code = inviteCode.trim();
    final inviteCodeRegex = RegExp(r'^\d{6}$');
    if (!inviteCodeRegex.hasMatch(code)) {
      _logger.w('Invalid invite code length: $code');
      return null;
    }

    try {
      final snapshot = await _firestore
          .collection('families')
          .where('invite_code', isEqualTo: code)
          .where('status', isEqualTo: 'active')
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        _logger.w('No active family found with invite code: $code');
        return null;
      }

      final family = FamilyModel.fromFirestore(snapshot.docs.first);
      if (family.inviteCodeExpiresAt.isBefore(DateTime.now())) {
        _logger.w('Invite code expired for family: ${family.familyId}');
        return null;
      }

      return family;
    } catch (e, stackTrace) {
      _logger.e(
        'Error getting family by invite code',
        error: e,
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
        _logger.w('User not found while checking family status: $uid');
        return false;
      }

      final data = doc.data();
      final familyId = data?['family_id'] as String?;
      return familyId != null && familyId.isNotEmpty;
    } catch (e, stackTrace) {
      _logger.e(
        'Error checking whether user already belongs to a family',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> joinFamily({
    required String familyId,
    required String childId,
    required String childName,
    String? avatarUrl,
  }) async {
    try {
      final familyRef = _firestore.collection('families').doc(familyId);
      final userRef = _firestore.collection('users').doc(childId);
      final memberRef = familyRef.collection('members').doc(childId);

      await _firestore.runTransaction((transaction) async {
        final familyDoc = await transaction.get(familyRef);
        final userDoc = await transaction.get(userRef);
        final memberDoc = await transaction.get(memberRef);

        if (!familyDoc.exists) {
          throw Exception('Family does not exist');
        }

        if (!userDoc.exists) {
          throw Exception('User does not exist');
        }

        final userData = userDoc.data();
        final currentFamilyId = userData?['family_id'] as String?;
        if (currentFamilyId != null && currentFamilyId.isNotEmpty) {
          throw Exception('User already belongs to a family');
        }

        if (memberDoc.exists) {
          return;
        }

        transaction.update(userRef, {
          'family_id': familyId,
          'family_role': 'child',
        });

        transaction.set(memberRef, {
          'uid': childId,
          'family_id': familyId,
          'role': 'child',
          'display_name': childName,
          'avatar_url': avatarUrl,
          'joined_at': FieldValue.serverTimestamp(),
          'status': 'active',
        });

        transaction.update(familyRef, {
          'child_count': FieldValue.increment(1),
          'updated_at': FieldValue.serverTimestamp(),
        });
      });
    } catch (e, stackTrace) {
      _logger.e(
        'Error joining family',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

@riverpod
LinkFamilyRepository linkFamilyRepository(LinkFamilyRepositoryRef ref) {
  return getIt<LinkFamilyRepository>();
}

