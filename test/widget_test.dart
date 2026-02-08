// This is a basic Flutter widget test for MoniKid.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:monikid/app/app.dart';

void main() {
  testWidgets('MoniKid app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MoniKidApp(),
      ),
    );

    // Wait for splash screen to load
    await tester.pump(const Duration(milliseconds: 500));

    // Verify that MoniKid text appears
    expect(find.text('MoniKid'), findsWidgets);
  });
}
