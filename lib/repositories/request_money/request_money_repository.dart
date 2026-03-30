import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_money_repository.g.dart';

abstract class RequestMoneyRepository {
  Future<void> createRequest(RequestMoneyModel request);
  Future<void> updateRequest(RequestMoneyModel request);
  Future<void> deleteRequest(String requestId);
}

class RequestMoneyRepositoryImpl implements RequestMoneyRepository {
  RequestMoneyRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  @override
  Future<void> createRequest(RequestMoneyModel request) async {
    try {
      _logger.i('Creating money request: ${request.id}');
      await _firestore.collection('money_requests').doc(request.id).set(request.toJson());
      _logger.i('Money request created successfully');
    } catch (e, stackTrace) {
      _logger.e('Error creating money request', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateRequest(RequestMoneyModel request) async {
    try {
      _logger.i('Updating money request: ${request.id}');
      await _firestore.collection('money_requests').doc(request.id).update(request.toJson());
      _logger.i('Money request updated successfully');
    } catch (e, stackTrace) {
      _logger.e('Error updating money request', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteRequest(String requestId) async {
    try {
      _logger.i('Deleting money request: $requestId');
      await _firestore.collection('money_requests').doc(requestId).delete();
      _logger.i('Money request deleted successfully');
    } catch (e, stackTrace) {
      _logger.e('Error deleting money request', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

@riverpod
RequestMoneyRepository requestMoneyRepository(Ref ref) {
  return getIt<RequestMoneyRepository>();
}
