import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:monikid/core/config/app_config.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/profile/profile_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

abstract class ProfileRepository {
  Future<ProfileModel?> getProfile(String uid);
  Future<String?> getProfileImage(String uid);
  Future<void> updateProfile(ProfileModel profile);
  Future<void> uploadAndUpdateAvatar({
    required String userId,
    required Uint8List bytes,
    required String mimeType,
  });
}

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(
    this._firestore,
    this._logger, {
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final FirebaseFirestore _firestore;
  final Logger _logger;
  final http.Client _httpClient;

  @override
  Future<ProfileModel?> getProfile(String uid) async {
    try {
      _logger.i('Getting profile for uid: $uid');
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        _logger.i('Profile loaded successfully for uid: $uid');
        return ProfileModel(
          id: doc.id,
          fullName: (data['display_name'] as String?)?.trim() ?? '',
          email: (data['email'] as String?)?.trim() ?? '',
          avatarUrl: data['avatar_url'] as String?,
          role: (data['role'] as String?)?.trim() ?? '',
          familyId: data['family_id'] as String?,
        );
      }
      _logger.w('Profile not found for uid: $uid');
      return null;
    } catch (e, stackTrace) {
      _logger.e('Error getting profile', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<String?> getProfileImage(String uid) async {
    try {
      _logger.i('Getting profile image for uid: $uid');
      final doc = await _firestore.collection('users').doc(uid).get();
      _logger.i('Profile image doc fetched for uid: $uid (exists=${doc.exists})');
      final data = doc.data();
      if (!doc.exists || data == null) {
        _logger.w('Profile image not found because profile is missing for uid: $uid');
        return null;
      }

      final url = data['avatar_url'] as String?;
      _logger.i('Profile image resolved for uid: $uid (hasUrl=${url != null})');
      return url;
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to get profile image.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      _logger.i('Updating profile for uid: ${profile.id}');
      await _firestore.collection('users').doc(profile.id).update({
        'display_name': profile.fullName,
        'updated_at': FieldValue.serverTimestamp(),
      });
      _logger.i('Profile updated successfully for uid: ${profile.id}');
      await _syncHostProfile(
        userId: profile.id,
        familyId: profile.familyId,
        displayName: profile.fullName,
      );
    } catch (e, stackTrace) {
      _logger.e('Error updating profile', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Denormalizes the host's name/avatar onto the family doc so the child app
  /// can read them with a single family-doc read. Only the host syncs — other
  /// members are read live from their user doc by the parent app.
  Future<void> _syncHostProfile({
    required String userId,
    required String? familyId,
    String? displayName,
    String? avatarUrl,
  }) async {
    if (familyId == null || familyId.isEmpty) return;
    try {
      _logger.i('Syncing host profile for user $userId in family $familyId.');
      final familyDoc = await _firestore.collection('families').doc(familyId).get();
      if (!familyDoc.exists) return;

      final members = (familyDoc.data()?['members'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();
      final me = members.firstWhere(
        (m) => m['user_id'] == userId,
        orElse: () => <String, dynamic>{},
      );
      if (me['family_role'] != 'host') {
        // Non-host members are not denormalized — nothing to sync.
        return;
      }

      final update = <String, dynamic>{'updated_at': FieldValue.serverTimestamp()};
      if (displayName != null) update['host_display_name'] = displayName;
      if (avatarUrl != null) update['host_avatar_url'] = avatarUrl;

      await _firestore.collection('families').doc(familyId).update(update);
      _logger.i('Host profile synced for user $userId.');
    } catch (error, stackTrace) {
      _logger.e('Failed to sync host profile.', error: error, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> uploadAndUpdateAvatar({
    required String userId,
    required Uint8List bytes,
    required String mimeType,
  }) async {
    final cloudName = AppConfig.cloudinaryCloudName;
    final uploadPreset = AppConfig.cloudinaryProfileAvatarUploadPreset;
    final publicId = 'profiles/$userId/avatar';

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload'),
    )
      ..fields['upload_preset'] = uploadPreset
      ..fields['public_id'] = publicId
      ..fields['resource_type'] = 'image'
      ..files.add(
        http.MultipartFile.fromBytes('file', bytes, filename: 'avatar'),
      );

    try {
      _logger.i('Uploading avatar to Cloudinary for user $userId.');
      final streamedResponse = await _httpClient.send(request);
      final responseBody = await streamedResponse.stream.bytesToString();
      if (streamedResponse.statusCode < 200 || streamedResponse.statusCode >= 300) {
        throw Exception(
          'Cloudinary avatar upload failed: ${streamedResponse.statusCode} $responseBody',
        );
      }

      final responseJson = jsonDecode(responseBody);
      if (responseJson is! Map<String, dynamic>) {
        throw Exception('Cloudinary avatar upload returned invalid JSON.');
      }

      final secureUrl = responseJson['secure_url'] as String?;
      if (secureUrl == null || secureUrl.trim().isEmpty) {
        throw Exception('Cloudinary avatar upload response is missing secure_url.');
      }

      _logger.i('Avatar uploaded. Updating Firestore for user $userId.');
      await _firestore.collection('users').doc(userId).update({
        'avatar_url': secureUrl,
        'updated_at': FieldValue.serverTimestamp(),
      });
      _logger.i('Avatar URL updated in Firestore for user $userId.');
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final familyId = userDoc.data()?['family_id'] as String?;
      await _syncHostProfile(
        userId: userId,
        familyId: familyId,
        avatarUrl: secureUrl,
      );
    } catch (error, stackTrace) {
      _logger.e('Failed to upload and update avatar.', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return getIt<ProfileRepository>();
}

@riverpod
Future<String?> profileImage(Ref ref, String uid) {
  return ref.watch(profileRepositoryProvider).getProfileImage(uid);
}
