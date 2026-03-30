import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/profile/profile_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

abstract class ProfileRepository {
  Future<ProfileModel?> getProfile(String uid);
  Future<void> updateProfile(ProfileModel profile);
}

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  @override
  Future<ProfileModel?> getProfile(String uid) async {
    try {
      _logger.i('Getting profile for uid: $uid');
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        data['id'] = doc.id;
        _logger.i('Profile loaded successfully for uid: $uid');
        return ProfileModel.fromJson(data);
      }
      _logger.w('Profile not found for uid: $uid');
      return null;
    } catch (e, stackTrace) {
      _logger.e('Error getting profile', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      _logger.i('Updating profile for uid: ${profile.id}');
      await _firestore.collection('users').doc(profile.id).update(profile.toJson());
      _logger.i('Profile updated successfully for uid: ${profile.id}');
    } catch (e, stackTrace) {
      _logger.e('Error updating profile', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return getIt<ProfileRepository>();
}
