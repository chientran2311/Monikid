import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/firebase_options.dart';
import 'package:monikid/core/utils/logger.dart';

import 'app/app.dart';
import 'package:monikid/core/di/di.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables (non-fatal if .env is empty/missing)
  try {
    await dotenv.load(fileName: '.env');
  } catch (error, stackTrace) {
    logger.w(
      'Could not load the .env file. Continuing with defaults.',
      error: error,
      stackTrace: stackTrace,
    );
  }

  // Set preferred orientations (portrait only for mobile)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0E1F18), // AppTheme.background
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize dependency injection
  await setupLocator();

  // Run the app
  runApp(const ProviderScope(child: MoniKidApp()));
}
