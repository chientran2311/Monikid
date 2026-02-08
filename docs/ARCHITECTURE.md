# ⚡️ MoniKid: Project Structure Guide (Clean Architecture + Feature-First)

This document outlines the project's folder structure after the refactoring.

## Folder Structure

```
lib/
├── app/                        # App-level configuration
│   ├── router.dart             # GoRouter navigation
│   └── theme.dart              # App theming
│
├── core/                       # Shared core utilities
│   ├── api.dart                # API keys (from .env)
│   ├── assets.dart             # Asset paths
│   ├── constants.dart          # App constants, Enums
│   ├── supabase_client.dart    # Supabase configuration
│   └── utils.dart              # Utility functions
│
├── data/                       # Shared data layer
│   └── models/                 # Freezed models (shared across features)
│       ├── user_model.dart
│       ├── family_model.dart
│       ├── wallet_model.dart
│       └── transaction_model.dart
│
├── features/                   # ⭐ FEATURE-FIRST
│   ├── auth/                   # Authentication feature
│   │   ├── data/
│   │   │   ├── repositories/   # Repository IMPL only
│   │   │   │   └── auth_repository_impl.dart
│   │   │   └── datasources/    # Data sources (if needed)
│   │   ├── domain/
│   │   │   ├── entities/       # Feature-specific entities (if any)
│   │   │   └── repositories/   # ⭐ Repository INTERFACES
│   │   │       └── auth_repository.dart
│   │   └── presentation/
│   │       ├── controllers/    # Riverpod Notifiers (generated)
│   │       ├── screens/        # Auth screens (Login, Register, Splash)
│   │       └── widgets/        # Feature-specific widgets
│   │
│   ├── parent/                 # Parent dashboard feature
│   │   └── ... (same structure)
│   │
│   ├── child/                  # Child dashboard feature
│   │   └── ... (same structure)
│   │
│   ├── wallet/                 # Wallet management feature
│   │   └── ... (same structure)
│   │
│   └── family/                 # Family management feature
│       └── ... (same structure)
│
├── shared/                     # Shared UI components
│   └── widgets/
│       ├── app_buttons.dart
│       ├── app_inputs.dart
│       └── app_cards.dart
│
└── main.dart
```

## Architecture Rules

### 1. Feature-First Organization
- Each feature is self-contained in its own folder
- Features can import from `core/`, `shared/`, and `models/`
- Features CANNOT import directly from other features
- If shared logic is needed, extract to `core/` or create a shared module

### 2. Clean Architecture Layers (Within Each Feature)
| Layer | Folder | Purpose |
|-------|--------|---------|
| **Data** | `data/` | Repositories (Impl), Data Sources |
| **Domain** | `domain/` | Entities (Freezed models), Repository Interfaces |
| **Presentation** | `presentation/` | Controllers (Riverpod), Screens, Widgets |

### 3. State Management (Riverpod + Freezed)
- Use `@riverpod` annotation for provider generation
- Use `ConsumerWidget` / `ConsumerStatefulWidget` for UI
- Use `AsyncNotifier` for async operations (loading, error states)
- Use `Freezed` for immutable models with `copyWith` and JSON serialization

### 4. Code Generation Commands
```bash
# Generate all .g.dart and .freezed.dart files
dart run build_runner build --delete-conflicting-outputs

# Watch for changes (during development)
dart run build_runner watch --delete-conflicting-outputs
```

## Dependency Injection

Providers are defined in `presentation/controllers/` and can be overridden in tests.

Example:
```dart
// Define provider (generated)
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(SupabaseConfig.client);
}

// Use in widget
class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    // ...
  }
}
```

## Next Steps

1. Migrate remaining features (Wallet, Family, Transactions)
2. Add tests in `test/` folder mirroring `lib/features/` structure
3. Create shared `core/failures.dart` for error handling
