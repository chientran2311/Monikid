import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monikid/core/utils/logger.dart';
import 'package:monikid/models/entities/profile/profile_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

abstract class ProfileRepository {
  Future<ProfileModel?> getProfile(String uid);
  Future<void> updateProfile(ProfileModel profile);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<ProfileModel?> getProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        data['id'] = doc.id;
        return ProfileModel.fromJson(data);
      }
      return null;
    } catch (e, stackTrace) {
      logger.e('Error getting profile', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      await _firestore.collection('users').doc(profile.id).update(profile.toJson());
    } catch (e, stackTrace) {
      logger.e('Error updating profile', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

@riverpod
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  return ProfileRepositoryImpl();
}
