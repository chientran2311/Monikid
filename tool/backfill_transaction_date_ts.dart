import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:monikid/firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;
  final snapshot = await firestore.collection('transactions').get();
  final batch = firestore.batch();
  var updatedCount = 0;

  for (final doc in snapshot.docs) {
    final data = doc.data();
    if (data['dateTs'] != null) {
      continue;
    }

    final rawDate = data['date'];
    DateTime? parsedDate;

    if (rawDate is Timestamp) {
      parsedDate = rawDate.toDate();
    } else if (rawDate is String) {
      parsedDate = DateTime.tryParse(rawDate);
    } else if (rawDate is DateTime) {
      parsedDate = rawDate;
    }

    if (parsedDate == null) {
      continue;
    }

    batch.update(doc.reference, {
      'dateTs': Timestamp.fromDate(parsedDate),
    });
    updatedCount++;
  }

  if (updatedCount == 0) {
    print('Khong co giao dich nao can backfill dateTs.');
    return;
  }

  await batch.commit();
  print('Da backfill dateTs cho $updatedCount giao dich.');
}
