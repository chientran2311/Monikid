# Local Storage Implementation Plan

This document outlines the architecture and implementation for data persistence in the Monikid app using `shared_preferences` and `flutter_secure_storage`, with `get_it` for dependency injection. 

## Proposed Architecture

### 1. Configuration Layer (`lib/core/config/`)

All storage keys are centralized here to prevent typos and hardcoding.

#### `lib/core/config/storage_keys.dart`
```dart
class StorageKeys {
  // Local
  static const String onboardCompleteKey = 'onboard_complete';
  // Secure
  static const String accessTokenKey = 'access_token';
}
```

### 2. Storage Layer (`lib/core/storage/`)

Wrappers for storage libraries that share a common API signature (`read`, `write`, `delete`, `clear`).

#### `lib/core/storage/local_storage.dart`
*   **Purpose:** Wrapper around `SharedPreferences` for storing non-sensitive flags (e.g., onboarding status, theme).
*   **Structure:**
    ```dart
    import 'package:shared_preferences/shared_preferences.dart';

    class AppLocalStorage {
      AppLocalStorage(this._prefs);
      final SharedPreferences _prefs;

      static Future<AppLocalStorage> create() async {
        final prefs = await SharedPreferences.getInstance();
        return AppLocalStorage(prefs);
      }

      Future<String?> read(String key) async {
        return _prefs.getString(key);
      }
      
      String? readSync(String key) {
        return _prefs.getString(key);
      }

      Future<void> write({required String key, required String? value}) async {
        if (value == null) {
          await delete(key: key);
        } else {
          await _prefs.setString(key, value);
        }
      }

      Future<void> delete({required String key}) async {
        await _prefs.remove(key);
      }

      Future<void> clear() async {
        await _prefs.clear();
      }
    }
    ```

#### `lib/core/storage/secure_storage.dart`
*   **Purpose:** Wrapper around `FlutterSecureStorage` for sensitive data (e.g., cached tokens or biometric flags).
*   **Structure:**
    ```dart
    import 'package:flutter_secure_storage/flutter_secure_storage.dart';

    class AppSecureStorage {
      AppSecureStorage() : _storage = _createSecureStorage();
      final FlutterSecureStorage _storage;

      static FlutterSecureStorage _createSecureStorage() {
        return const FlutterSecureStorage(
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.unlocked_this_device,
          ),
        );
      }

      Future<String?> read(String key) async {
        return await _storage.read(key: key);
      }

      Future<void> write({required String key, required String? value}) async {
        if (value == null) {
          await delete(key: key);
        } else {
          await _storage.write(key: key, value: value);
        }
      }

      Future<void> delete({required String key}) async {
        await _storage.delete(key: key);
      }

      Future<void> clear() async {
        await _storage.deleteAll();
      }
    }
    ```

### 2. Dependency Injection (`lib/core/di/di.dart`)

Use `get_it` to register storage instances uniquely at app startup so they can be accessed anywhere without context.

*   **Implementation:**
    Modify the existing `configureDependencies()` function:
    ```dart
    import 'package:monikid/core/storage/local_storage.dart';
    import 'package:monikid/core/storage/secure_storage.dart';

    // ... existing imports ...

    @InjectableInit(...)
    Future configureDependencies() async {
      // Initialize local storage first
      final localStorage = await AppLocalStorage.create();
      getIt.registerSingleton<AppLocalStorage>(localStorage);
      
      // Register secure storage as lazy singleton
      getIt.registerLazySingleton<AppSecureStorage>(() => AppSecureStorage());

      return getIt.init();
    }
    ```

### 3. Usage inside the App
*   Anywhere in the application (like Router or Providers), use `getIt<AppLocalStorage>()` or `getIt<AppSecureStorage>()` to access storage without creating new instances.
*   Example in Router:
    ```dart
    final isFirstLaunch = getIt<AppLocalStorage>().readSync(AppLocalStorage.onboardCompleteKey) == null;
    ```
