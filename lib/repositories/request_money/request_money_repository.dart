import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monikid/core/utils/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_money_repository.g.dart';

abstract class RequestMoneyRepository {
  Future<void> createRequest(RequestMoneyModel request);
  Future<void> updateRequest(RequestMoneyModel request);
  Future<void> deleteRequest(String requestId);
}

class RequestMoneyRepositoryImpl implements RequestMoneyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createRequest(RequestMoneyModel request) async {
    try {
      await _firestore.collection('money_requests').doc(request.id).set(request.toJson());
    } catch (e, stackTrace) {
      logger.e('Error creating money request', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> updateRequest(RequestMoneyModel request) async {
    try {
      await _firestore.collection('money_requests').doc(request.id).update(request.toJson());
    } catch (e, stackTrace) {
      logger.e('Error updating money request', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> deleteRequest(String requestId) async {
    try {
      await _firestore.collection('money_requests').doc(requestId).delete();
    } catch (e, stackTrace) {
      logger.e('Error deleting money request', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

@riverpod
RequestMoneyRepository requestMoneyRepository(Ref ref) {
  return RequestMoneyRepositoryImpl();
}
