---
name: refactor-provider
description: Refactor Riverpod/Bloc providers by applying Clean Architecture principles. Extract business logic from providers to repositories, create request (param) and response models for complex methods, and use GetIt for dependency injection.
---
# Provider Refactoring Skill

This skill guides you through refactoring Flutter providers (like Riverpod or Bloc classes) to follow Clean Architecture principles.

## When to Use
- User wants to refactor a Provider to be cleaner.
- The provider contains heavy logic (API calls, data transformations, Firebase interactions).
- User asks to "refactor provider," "extract logic to repository," "use params and responses," or "use GetIt."

## Core Principles
1. **Providers only manage state:** Providers should not contain complex logic. They only handle state changes (`isLoading`, `errorMessage`, `success`).
2. **Logic in Repositories:** All API calls, Firestore operations, and business logic belong in the `RepositoryImpl`.
3. **Use GetIt for DI:** Providers should not instantiate repositories. Instead, they retrieve them via `GetIt.instance<MyRepository>()` or `getIt<MyRepository>()`.
4. **Use Param and Response Models:**
   - Instead of passing multiple arguments to a function (e.g., `String email, String password`), create a `Param` model (e.g., `SignInParam`).
   - Instead of returning complex tuples or primitive collections, create a `Response` model (e.g., `SignInResponse`).
   - Place these models in the appropriate folders (e.g., `domain/params/` and `domain/responses/`).

## Step-by-Step Workflow

### 1. Analyze the Provider
- Identify all public methods that contain business logic (e.g., `signIn()`, `signUp()`).
- Note the arguments they take and the values they return.

### 2. Create Param and Response Models
- For each complex method, create a Param model class.
  - Location: `lib/features/[feature]/domain/params/[action]_param.dart`
- If the method returns data, create a Response model class.
  - Location: `lib/features/[feature]/domain/responses/[action]_response.dart`
- Use `freezed` or plain Dart data classes based on the project's convention.

### 3. Update the Repository Interface and Implementation
- Update the abstract `Repository` interface using the new Param and Response models.
- Implement the logic in `RepositoryImpl`. Move all Firestore, API, and validation logic here.

### 4. Refactor the Provider
- Replace direct instantiations of the repository (e.g., `_authRepository = AuthRepositoryImpl(...)`) with GetIt:
  ```dart
  import 'package:get_it/get_it.dart';
  
  final _repository = GetIt.I<AuthRepository>();
  // or your project's equivalent GetIt accessor
  ```
- Rewrite the provider's methods to build the `Param` object, call the repository, handle the `Response` (or errors), and update the state.

### 5. Verify Setup
- Ensure `GetIt` is correctly providing the repository in the project's dependency injection/locator setup file (e.g., `injection.dart` or `di.dart`).
- Run `dart format` and `flutter analyze`.

## Example
**Before:**
```dart
class AuthProvider extends _$AuthProvider {
  final AuthRepository _repo = AuthRepositoryImpl();
  
  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      // Heavy logic in provider or tightly coupled repo
      final user = await _repo.signInWithFirebase(email, password); 
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
```

**After:**
```dart
import 'package:get_it/get_it.dart';

class AuthProvider extends _$AuthProvider {
  final AuthRepository _repo = GetIt.I<AuthRepository>();
  
  Future<void> signIn(SignInParam param) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _repo.signIn(param);
      state = state.copyWith(user: response.user, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
```
