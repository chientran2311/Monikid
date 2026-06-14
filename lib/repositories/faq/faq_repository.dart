import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/faq/faq_model.dart';

part 'faq_repository.g.dart';

abstract class FAQRepository {
  Future<List<FAQModel>> getFAQs({required String langCode});
}

class FAQRepositoryImpl implements FAQRepository {
  FAQRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  @override
  Future<List<FAQModel>> getFAQs({required String langCode}) async {
    try {
      _logger.i('Loading FAQs for language: $langCode');
      final querySnapshot = await _firestore
          .collection('faqs')
          .doc(langCode)
          .collection('items')
          .orderBy(FieldPath.documentId)
          .get();

      final faqs = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Inject document ID into data
        return FAQModel.fromJson(data);
      }).toList();
      _logger.i('Loaded ${faqs.length} FAQs successfully');
      return faqs;
    } catch (e, stackTrace) {
      _logger.e('Error loading FAQs', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

@riverpod
FAQRepository faqRepository(Ref ref) {
  return getIt<FAQRepository>();
}
