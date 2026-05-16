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

  String? _readProfileImageUrl(Map<String, dynamic> data) {
    final avatarUrl = (data['avatar_url'] as String?)?.trim();
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return avatarUrl;
    }

    final photoUrl = (data['photo_url'] as String?)?.trim();
    if (photoUrl != null && photoUrl.isNotEmpty) {
      return photoUrl;
    }

    return null;
  }

  @override
  Future<ProfileModel?> getProfile(String uid) async {
    try {
      _logger.i('Getting profile for uid: $uid');
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        _logger.i('Profile loaded successfully for uid: $uid');
        final fullName = (data['full_name'] as String? ?? data['display_name'] as String?)?.trim() ?? '';
        final avatarUrl = _readProfileImageUrl(data);
        return ProfileModel(
          id: doc.id,
          fullName: fullName,
          email: (data['email'] as String?)?.trim() ?? '',
          avatarUrl: avatarUrl,
          phone: (data['phone'] as String?) ?? '',
          dob: (data['dob'] as String?) ?? '',
          gender: (data['gender'] as String?) ?? '',
          role: (data['role'] as String?)?.trim() ?? '',
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
      final data = doc.data();
      if (!doc.exists || data == null) {
        _logger.w('Profile image not found because profile is missing for uid: $uid');
        return null;
      }

      return _readProfileImageUrl(data);
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
        'full_name': profile.fullName,
        'phone': profile.phone.isEmpty ? null : profile.phone,
        'dob': profile.dob.isEmpty ? null : profile.dob,
        'gender': profile.gender.isEmpty ? null : profile.gender,
        'updated_at': FieldValue.serverTimestamp(),
      });
      _logger.i('Profile updated successfully for uid: ${profile.id}');
    } catch (e, stackTrace) {
      _logger.e('Error updating profile', error: e, stackTrace: stackTrace);
      rethrow;
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
