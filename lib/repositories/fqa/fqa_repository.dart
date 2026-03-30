import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/fqa/fqa_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fqa_repository.g.dart';

abstract class FQARepository {
  Future<List<FQAModel>> getFAQs({required String langCode});
}

class FQARepositoryImpl implements FQARepository {
  FQARepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  @override
  Future<List<FQAModel>> getFAQs({required String langCode}) async {
    try {
      _logger.i('Loading FAQs for language: $langCode');
      final querySnapshot = await _firestore
          .collection('faqs')
          .where('language', isEqualTo: langCode)
          .orderBy('orderIndex')
          .get();

      final faqs = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Inject document ID into data
        return FQAModel.fromJson(data);
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
FQARepository fqaRepository(FqaRepositoryRef ref) {
  return getIt<FQARepository>();
}
