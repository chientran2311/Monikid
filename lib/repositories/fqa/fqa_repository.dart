import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monikid/core/utils/logger.dart';
import 'package:monikid/features/fqa/domain/fqa_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fqa_repository.g.dart';

abstract class FQARepository {
  Future<List<FQAModel>> getFAQs({required String langCode});
}

class FQARepositoryImpl implements FQARepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<FQAModel>> getFAQs({required String langCode}) async {
    try {
      final querySnapshot = await _firestore
          .collection('faqs')
          .where('language', isEqualTo: langCode)
          .orderBy('orderIndex')
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Inject document ID into data
        return FQAModel.fromJson(data);
      }).toList();
    } catch (e, stackTrace) {
      logger.e('Error loading FAQs', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

@riverpod
FQARepository fqaRepository(FqaRepositoryRef ref) {
  return FQARepositoryImpl();
}
