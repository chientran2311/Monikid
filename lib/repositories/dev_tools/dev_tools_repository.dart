import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'dev_tools_repository.g.dart';

abstract class DevToolsRepository {
  Future<int> seedMockFaq();
  Future<void> addMockTransaction({
    required String userId,
    required DateTime date,
    required String type,
    required CategoryModel category,
  });
}

@riverpod
DevToolsRepository devToolsRepository(Ref ref) {
  return getIt<DevToolsRepository>();
}

class DevToolsRepositoryImpl implements DevToolsRepository {
  DevToolsRepositoryImpl({
    required FirebaseFirestore firestore,
    required TransactionRepository transactionRepository,
    required Logger logger,
  })  : _firestore = firestore,
        _transactionRepository = transactionRepository,
        _logger = logger;

  final FirebaseFirestore _firestore;
  final TransactionRepository _transactionRepository;
  final Logger _logger;

  // `language` chỉ dùng để định tuyến path `faqs/{language}/items`, KHÔNG ghi vào doc body.
  static const _mockFaqs = [
    {
      'question': 'Làm thế nào để đặt hạn mức chi tiêu?',
      'answer': 'Vào Trang chủ → nhấn vào khu vực "Hạn mức" → nhập số tiền và nhấn Lưu.',
      'language': 'vi',
    },
    {
      'question': 'Tôi có thể thêm danh mục tùy chỉnh không?',
      'answer': 'Có. Khi thêm giao dịch, chọn "Tạo danh mục mới". Mỗi tài khoản được tối đa 5 danh mục tùy chỉnh.',
      'language': 'vi',
    },
    {
      'question': 'Làm sao để xem lịch sử giao dịch?',
      'answer': 'Nhấn vào biểu tượng đồng hồ ở thanh điều hướng dưới cùng để xem toàn bộ lịch sử.',
      'language': 'vi',
    },
    {
      'question': 'Ứng dụng có hỗ trợ chụp hóa đơn không?',
      'answer': 'Có! Khi thêm giao dịch, nhấn biểu tượng camera để chụp hoặc chọn ảnh hóa đơn từ thư viện.',
      'language': 'vi',
    },
    {
      'question': 'Làm thế nào để đổi mã PIN?',
      'answer': 'Vào Cài đặt → Hồ sơ → Đổi PIN → nhập PIN hiện tại và PIN mới.',
      'language': 'vi',
    },
    {
      'question': 'How do I set a spending limit?',
      'answer': 'Go to Home → tap the "Limit" area → enter the amount and tap Save.',
      'language': 'en',
    },
    {
      'question': 'Can I add custom categories?',
      'answer': 'Yes. When adding a transaction, choose "Create new category". Each account supports up to 5 custom categories.',
      'language': 'en',
    },
    {
      'question': 'How do I view transaction history?',
      'answer': 'Tap the clock icon in the bottom navigation bar to view all transaction history.',
      'language': 'en',
    },
    {
      'question': 'Does the app support receipt scanning?',
      'answer': 'Yes! When adding a transaction, tap the camera icon to take a photo or select a receipt from your gallery.',
      'language': 'en',
    },
    {
      'question': 'How do I change my PIN?',
      'answer': 'Go to Settings → Profile → Change PIN → enter your current PIN and new PIN.',
      'language': 'en',
    },
  ];

  @override
  Future<int> seedMockFaq() async {
    _logger.d('DevToolsRepositoryImpl.seedMockFaq: start. count=${_mockFaqs.length}');
    try {
      final batch = _firestore.batch();
      final now = Timestamp.now();
      final seqByLang = <String, int>{};
      for (final faq in _mockFaqs) {
        final lang = faq['language'] as String;
        final seq = (seqByLang[lang] ?? 0) + 1;
        seqByLang[lang] = seq;
        final docId = seq.toString().padLeft(3, '0'); // 001, 002...
        final docRef = _firestore
            .collection('faqs')
            .doc(lang)
            .collection('items')
            .doc(docId);
        batch.set(docRef, {
          'question': faq['question'],
          'answer': faq['answer'],
          'created_at': now,
        });
      }
      await batch.commit();
      _logger.i('DevToolsRepositoryImpl.seedMockFaq: success. count=${_mockFaqs.length}');
      return _mockFaqs.length;
    } catch (error, stackTrace) {
      _logger.e('DevToolsRepositoryImpl.seedMockFaq failed.', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> addMockTransaction({
    required String userId,
    required DateTime date,
    required String type,
    required CategoryModel category,
  }) async {
    _logger.d('DevToolsRepositoryImpl.addMockTransaction: userId=$userId, type=$type, category=${category.id}, date=$date');
    try {
      final random = Random();
      final amount = type == 'expense'
          ? 20000 + random.nextInt(480001)
          : 100000 + random.nextInt(1900001);
      final now = DateTime.now();
      final transaction = TransactionModel(
        transactionId: const Uuid().v4(),
        userId: userId,
        amountMinor: amount,
        type: type,
        categoryKey: category.id,
        categoryLabel: category.label,
        categoryIcon: category.icon,
        dateTs: date,
        createdAt: now,
        updatedAt: now,
        note: 'Mock transaction - DevTools',
        source: 'manual',
      );
      await _transactionRepository.addTransaction(transaction);
      _logger.i('DevToolsRepositoryImpl.addMockTransaction: success. amount=$amount');
    } catch (error, stackTrace) {
      _logger.e('DevToolsRepositoryImpl.addMockTransaction failed.', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
