---
name: flutter-feature-dev
description: Develop complete features in Flutter projects following clean architecture. Use when users request feature implementation, new functionality, or complete module development in Flutter apps. This skill handles the entire workflow from understanding the codebase structure, checking dependencies, implementing models with Freezed, creating repositories, setting up state management with Riverpod/Bloc, and building UI components. Trigger this whenever users mention "implement feature", "add new functionality", "create module", "develop feature", "build feature", or describe a complete feature they want to add to their Flutter app.
---

# Flutter Feature Development Skill

This skill guides you through implementing complete features in Flutter projects following clean architecture principles with proper separation of concerns.

## When to Use

Use this skill when:
- User wants to implement a new feature in a Flutter app
- User needs to add functionality that involves database, state management, and UI
- User mentions specific Flutter patterns (Freezed, Riverpod, Bloc, Repository pattern)
- User describes a feature that requires full-stack implementation from model to UI
- User wants to follow clean architecture/best practices in Flutter

## Prerequisites Check

Before starting ANY feature development, ALWAYS verify the project has required dependencies.

## Development Workflow

Follow this sequence strictly for consistent, high-quality feature implementation:

### Phase 1: Project Understanding (ALWAYS START HERE)

Before touching any code, understand the project structure:

1. **Locate and read the project overview file**
   - Look for files like: `README.md`, `ARCHITECTURE.md`, `PROJECT_STRUCTURE.md`, `docs/overview.md`
   - If not found, ask user for project documentation
   - Understand:
     - Project architecture (clean architecture, layered, etc.)
     - Folder structure conventions
     - Naming conventions
     - Current features and modules

2. **Analyze existing codebase structure**
   ```bash
   # Map the project structure
   find . -type d -name "lib" -exec tree -L 3 {} \;
   
   # Or examine key directories
   ls -la lib/
   ls -la lib/features/ 2>/dev/null
   ls -la lib/domain/ 2>/dev/null
   ls -la lib/data/ 2>/dev/null
   ls -la lib/presentation/ 2>/dev/null
   ```

3. **Identify project patterns**
   - Check if project uses feature-based or layer-based structure
   - Identify state management approach (check existing providers/blocs)
   - Find existing models to understand freezed/json_serializable usage
   - Locate repository pattern implementations

### Phase 2: Dependency Verification (CRITICAL)

**NEVER skip this step.** Check `pubspec.yaml` for required packages:

```bash
# Read pubspec.yaml
cat pubspec.yaml
```

Required dependencies checklist:
- [ ] `freezed_annotation` - For immutable models
- [ ] `json_annotation` - For JSON serialization
- [ ] `riverpod` / `flutter_riverpod` / `riverpod_annotation` OR `bloc` / `flutter_bloc` - State management
- [ ] `build_runner` - Code generation
- [ ] `freezed` (dev) - Code generation for models
- [ ] `json_serializable` (dev) - JSON serialization generation
- [ ] Database: `firebase_core`, `cloud_firestore` OR `supabase_flutter`
- [ ] `go_router` / `auto_route` - Navigation (if used)

**If ANY dependency is missing:**
1. Inform user which packages are missing
2. Add them to pubspec.yaml:

```yaml
dependencies:
  flutter:
    sdk: flutter
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  flutter_riverpod: ^2.4.10  # or flutter_bloc: ^8.1.3
  firebase_core: ^2.24.2  # or supabase_flutter: ^2.0.0
  cloud_firestore: ^4.13.6  # if using Firebase
  go_router: ^13.0.0

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  riverpod_generator: ^2.3.9  # if using riverpod_annotation
```

3. Run: `flutter pub get`

### Phase 3: UI Assessment

Determine if UI already exists:

```bash
# Search for potential UI files
find lib -name "*_screen.dart" -o -name "*_page.dart" -o -name "*_view.dart"
```

**Decision path:**
- **No UI exists**: Proceed to create basic UI scaffold (simple screen with placeholder) in Phase 8
- **UI exists**: Focus on database integration and business logic in phases 4-7, then enhance UI in Phase 8

### Phase 4: Database Schema Analysis (CRITICAL)

**NEVER proceed without understanding the database structure.**

#### For Firebase:
1. Ask user to describe Firestore collections structure OR share Firebase console screenshot
2. Document the schema:
   ```
   Collection: users
   Fields:
   - id: string
   - name: string
   - email: string
   - createdAt: Timestamp
   
   Collection: posts
   Fields:
   - id: string
   - userId: string (reference to users)
   - title: string
   - content: string
   - likes: number
   ```

#### For Supabase:
1. Ask user to share table schema OR provide SQL create statements
2. Document the schema:
   ```sql
   CREATE TABLE users (
     id UUID PRIMARY KEY,
     name TEXT NOT NULL,
     email TEXT UNIQUE NOT NULL,
     created_at TIMESTAMPTZ DEFAULT NOW()
   );
   
   CREATE TABLE posts (
     id UUID PRIMARY KEY,
     user_id UUID REFERENCES users(id),
     title TEXT NOT NULL,
     content TEXT,
     likes INTEGER DEFAULT 0
   );
   ```

**Key questions to ask:**
- What are the table/collection names?
- What are all the fields and their types?
- Are there relationships between tables/collections?
- Are there any indexes or constraints?
- What are the query patterns for this feature?

### Phase 5: Model Development (First Implementation)

Create Freezed models based on database schema.

**File location:** Follow project structure, typically:
- `lib/domain/models/` or
- `lib/features/[feature_name]/domain/models/` or
- `lib/models/`

**Model template with Freezed + JSON serialization:**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // or supabase equivalent

part '[model_name].freezed.dart';
part '[model_name].g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default(0) int postCount,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  // For Firestore: Add fromFirestore factory
  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User.fromJson({
      'id': doc.id,
      ...data,
      'created_at': (data['created_at'] as Timestamp).toDate().toIso8601String(),
    });
  }
  
  // For Firestore: Add toFirestore method
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id'); // Firestore ID is separate
    json['created_at'] = Timestamp.fromDate(createdAt);
    return json;
  }
}
```

**After creating models:**
```bash
# Generate code
dart run build_runner build --delete-conflicting-outputs
```

**Key patterns:**
- Use `@JsonKey()` for field name mapping (snake_case in DB ↔ camelCase in Dart)
- Use `@Default()` for default values
- Add `fromFirestore`/`fromSupabase` factory constructors
- Add `toFirestore`/`toSupabase` methods
- Handle DateTime ↔ Timestamp conversions for Firestore
- Make factory `const` when possible

### Phase 6: Repository Layer (Second Implementation)

Implement the repository pattern with abstract interface and concrete implementation.

**Structure:**
```
lib/
  features/[feature_name]/
    domain/
      repositories/
        [feature]_repository.dart  // Abstract interface
    data/
      repositories/
        [feature]_repository_impl.dart  // Concrete implementation
```

**Step 6.1: Create Abstract Repository Interface**

```dart
// lib/features/user/domain/repositories/user_repository.dart
import 'package:dartz/dartz.dart'; // for Either (optional but recommended)
import '../../domain/models/user.dart';

abstract class UserRepository {
  // Read operations
  Future<Either<Exception, User>> getUser(String userId);
  Future<Either<Exception, List<User>>> getAllUsers();
  Stream<List<User>> watchUsers(); // For real-time updates
  
  // Write operations
  Future<Either<Exception, void>> createUser(User user);
  Future<Either<Exception, void>> updateUser(User user);
  Future<Either<Exception, void>> deleteUser(String userId);
  
  // Custom queries
  Future<Either<Exception, List<User>>> searchUsers(String query);
}
```

**Step 6.2: Create Repository Implementation**

**For Firebase:**
```dart
// lib/features/user/data/repositories/user_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  
  UserRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  
  CollectionReference<Map<String, dynamic>> get _usersRef =>
      _firestore.collection('users');
  
  @override
  Future<Either<Exception, User>> getUser(String userId) async {
    try {
      final doc = await _usersRef.doc(userId).get();
      if (!doc.exists) {
        return Left(Exception('User not found'));
      }
      return Right(User.fromFirestore(doc));
    } catch (e) {
      return Left(Exception('Failed to get user: $e'));
    }
  }
  
  @override
  Future<Either<Exception, List<User>>> getAllUsers() async {
    try {
      final snapshot = await _usersRef.get();
      final users = snapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
      return Right(users);
    } catch (e) {
      return Left(Exception('Failed to get users: $e'));
    }
  }
  
  @override
  Stream<List<User>> watchUsers() {
    return _usersRef.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => User.fromFirestore(doc)).toList(),
    );
  }
  
  @override
  Future<Either<Exception, void>> createUser(User user) async {
    try {
      await _usersRef.doc(user.id).set(user.toFirestore());
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to create user: $e'));
    }
  }
  
  @override
  Future<Either<Exception, void>> updateUser(User user) async {
    try {
      await _usersRef.doc(user.id).update(user.toFirestore());
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to update user: $e'));
    }
  }
  
  @override
  Future<Either<Exception, void>> deleteUser(String userId) async {
    try {
      await _usersRef.doc(userId).delete();
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to delete user: $e'));
    }
  }
  
  @override
  Future<Either<Exception, List<User>>> searchUsers(String query) async {
    try {
      final snapshot = await _usersRef
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .get();
      final users = snapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
      return Right(users);
    } catch (e) {
      return Left(Exception('Failed to search users: $e'));
    }
  }
}
```

**For Supabase:**
```dart
// lib/features/user/data/repositories/user_repository_impl.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient _supabase;
  
  UserRepositoryImpl({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;
  
  @override
  Future<Either<Exception, User>> getUser(String userId) async {
    try {
      final data = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single();
      return Right(User.fromJson(data));
    } catch (e) {
      return Left(Exception('Failed to get user: $e'));
    }
  }
  
  @override
  Future<Either<Exception, List<User>>> getAllUsers() async {
    try {
      final data = await _supabase.from('users').select();
      final users = (data as List).map((json) => User.fromJson(json)).toList();
      return Right(users);
    } catch (e) {
      return Left(Exception('Failed to get users: $e'));
    }
  }
  
  @override
  Stream<List<User>> watchUsers() {
    return _supabase
        .from('users')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((json) => User.fromJson(json)).toList());
  }
  
  @override
  Future<Either<Exception, void>> createUser(User user) async {
    try {
      await _supabase.from('users').insert(user.toJson());
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to create user: $e'));
    }
  }
  
  @override
  Future<Either<Exception, void>> updateUser(User user) async {
    try {
      await _supabase
          .from('users')
          .update(user.toJson())
          .eq('id', user.id);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to update user: $e'));
    }
  }
  
  @override
  Future<Either<Exception, void>> deleteUser(String userId) async {
    try {
      await _supabase.from('users').delete().eq('id', userId);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to delete user: $e'));
    }
  }
  
  @override
  Future<Either<Exception, List<User>>> searchUsers(String query) async {
    try {
      final data = await _supabase
          .from('users')
          .select()
          .ilike('name', '%$query%');
      final users = (data as List).map((json) => User.fromJson(json)).toList();
      return Right(users);
    } catch (e) {
      return Left(Exception('Failed to search users: $e'));
    }
  }
}
```

**Repository best practices:**
- Always wrap in try-catch
- Return `Either<Exception, T>` for error handling (or use custom Result type)
- Use streams for real-time data
- Keep repository focused on data operations only (no business logic)
- Inject dependencies (don't use singletons directly)

### Phase 7: State Management Layer (Third Implementation)

Choose based on project's existing pattern:

#### Option A: Riverpod (with riverpod_annotation)

**Step 7.1: Create Provider File**

```dart
// lib/features/user/presentation/providers/user_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/user_repository.dart';

part 'user_provider.g.dart';

// Repository provider
@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl();
}

// State notifier for user list
@riverpod
class UserList extends _$UserList {
  @override
  FutureOr<List<User>> build() async {
    return _fetchUsers();
  }
  
  Future<List<User>> _fetchUsers() async {
    final repository = ref.read(userRepositoryProvider);
    final result = await repository.getAllUsers();
    return result.fold(
      (error) => throw error,
      (users) => users,
    );
  }
  
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchUsers());
  }
  
  Future<void> addUser(User user) async {
    final repository = ref.read(userRepositoryProvider);
    final result = await repository.createUser(user);
    
    result.fold(
      (error) => throw error,
      (_) => refresh(),
    );
  }
  
  Future<void> updateUser(User user) async {
    final repository = ref.read(userRepositoryProvider);
    final result = await repository.updateUser(user);
    
    result.fold(
      (error) => throw error,
      (_) => refresh(),
    );
  }
  
  Future<void> deleteUser(String userId) async {
    final repository = ref.read(userRepositoryProvider);
    final result = await repository.deleteUser(userId);
    
    result.fold(
      (error) => throw error,
      (_) => refresh(),
    );
  }
}

// Stream provider for real-time updates
@riverpod
Stream<List<User>> userStream(UserStreamRef ref) {
  final repository = ref.watch(userRepositoryProvider);
  return repository.watchUsers();
}

// Single user provider
@riverpod
Future<User> user(UserRef ref, String userId) async {
  final repository = ref.watch(userRepositoryProvider);
  final result = await repository.getUser(userId);
  return result.fold(
    (error) => throw error,
    (user) => user,
  );
}
```

**Step 7.2: Generate Provider Code**
```bash
dart run build_runner build --delete-conflicting-outputs
```

#### Option B: Bloc

**Step 7.1: Create Events**
```dart
// lib/features/user/presentation/bloc/user_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/user.dart';

part 'user_event.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.loadUsers() = LoadUsers;
  const factory UserEvent.loadUser(String userId) = LoadUser;
  const factory UserEvent.createUser(User user) = CreateUser;
  const factory UserEvent.updateUser(User user) = UpdateUser;
  const factory UserEvent.deleteUser(String userId) = DeleteUser;
  const factory UserEvent.searchUsers(String query) = SearchUsers;
}
```

**Step 7.2: Create States**
```dart
// lib/features/user/presentation/bloc/user_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/user.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = Initial;
  const factory UserState.loading() = Loading;
  const factory UserState.loaded(List<User> users) = Loaded;
  const factory UserState.error(String message) = Error;
}
```

**Step 7.3: Create Bloc**
```dart
// lib/features/user/presentation/bloc/user_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  
  UserBloc({required this.repository}) : super(const UserState.initial()) {
    on<LoadUsers>(_onLoadUsers);
    on<CreateUser>(_onCreateUser);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
    on<SearchUsers>(_onSearchUsers);
  }
  
  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(const UserState.loading());
    
    final result = await repository.getAllUsers();
    result.fold(
      (error) => emit(UserState.error(error.toString())),
      (users) => emit(UserState.loaded(users)),
    );
  }
  
  Future<void> _onCreateUser(CreateUser event, Emitter<UserState> emit) async {
    final result = await repository.createUser(event.user);
    result.fold(
      (error) => emit(UserState.error(error.toString())),
      (_) => add(const LoadUsers()),
    );
  }
  
  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    final result = await repository.updateUser(event.user);
    result.fold(
      (error) => emit(UserState.error(error.toString())),
      (_) => add(const LoadUsers()),
    );
  }
  
  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    final result = await repository.deleteUser(event.userId);
    result.fold(
      (error) => emit(UserState.error(error.toString())),
      (_) => add(const LoadUsers()),
    );
  }
  
  Future<void> _onSearchUsers(SearchUsers event, Emitter<UserState> emit) async {
    emit(const UserState.loading());
    
    final result = await repository.searchUsers(event.query);
    result.fold(
      (error) => emit(UserState.error(error.toString())),
      (users) => emit(UserState.loaded(users)),
    );
  }
}
```

**Step 7.4: Generate Bloc Code**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Phase 8: UI Implementation (Final Step)

**Determine UI approach based on Phase 3 assessment:**

#### Scenario A: No UI exists - Create new screens

**File location:** Follow project structure, typically:
- `lib/features/[feature_name]/presentation/screens/` or
- `lib/features/[feature_name]/presentation/pages/` or
- `lib/screens/` or
- `lib/ui/screens/`

**With Riverpod:**
```dart
// lib/features/user/presentation/screens/user_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_provider.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(userListProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(userListProvider),
          ),
        ],
      ),
      body: usersAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await ref.read(userListProvider.notifier).deleteUser(user.id);
                  },
                ),
                onTap: () {
                  // Navigate to detail screen
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add user screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

**With Bloc:**
```dart
// lib/features/user/presentation/screens/user_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<UserBloc>().add(const UserEvent.loadUsers());
            },
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Press refresh to load users')),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (users) {
              if (users.isEmpty) {
                return const Center(child: Text('No users found'));
              }
              
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<UserBloc>().add(
                          UserEvent.deleteUser(user.id),
                        );
                      },
                    ),
                    onTap: () {
                      // Navigate to detail screen
                    },
                  );
                },
              );
            },
            error: (message) => Center(
              child: Text('Error: $message'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add user screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

#### Scenario B: UI exists - Integrate with existing screens

1. **Locate existing UI files**
2. **Inject providers/blocs:**

**For Riverpod:**
```dart
// Update existing screen to use providers
final usersAsync = ref.watch(userListProvider);
// Replace existing data fetching logic
```

**For Bloc:**
```dart
// Wrap screen with BlocProvider in main.dart or router
BlocProvider(
  create: (context) => UserBloc(
    repository: UserRepositoryImpl(),
  )..add(const UserEvent.loadUsers()),
  child: UserListScreen(),
)
```

3. **Update UI widgets to display data from state management**
4. **Add loading states and error handling**
5. **Connect user actions to state management methods**

### Phase 9: Navigation Setup (If using go_router)

**Add routes for new screens:**

```dart
// lib/router/app_router.dart
import 'package:go_router/go_router.dart';
import '../features/user/presentation/screens/user_list_screen.dart';

final router = GoRouter(
  routes: [
    // ... existing routes
    GoRoute(
      path: '/users',
      builder: (context, state) => const UserListScreen(),
    ),
    GoRoute(
      path: '/users/:id',
      builder: (context, state) {
        final userId = state.pathParameters['id']!;
        return UserDetailScreen(userId: userId);
      },
    ),
  ],
);
```

### Phase 10: Testing & Validation

Before considering the feature complete:

1. **Test CRUD operations:**
   ```dart
   // Run the app and verify:
   // ✓ Create new items
   // ✓ Read/display items
   // ✓ Update items
   // ✓ Delete items
   ```

2. **Test error scenarios:**
   - Network errors
   - Invalid data
   - Database errors

3. **Test UI states:**
   - Loading state
   - Empty state
   - Error state
   - Success state

4. **Verify code generation:**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   flutter pub get
   flutter analyze
   ```

## Common Patterns & Tips

### Error Handling Pattern

Use `Either` from `dartz` or create custom Result type:

```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  const Failure(this.message);
}
```

### Loading State Pattern

Always handle loading, success, and error states in UI:

```dart
// Riverpod
usersAsync.when(
  data: (data) => /* success UI */,
  loading: () => /* loading UI */,
  error: (error, stack) => /* error UI */,
)

// Bloc
state.when(
  initial: () => /* initial UI */,
  loading: () => /* loading UI */,
  loaded: (data) => /* success UI */,
  error: (message) => /* error UI */,
)
```

### Dependency Injection Pattern

Always inject dependencies (don't use singletons directly):

```dart
class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  
  // ✓ Good: Injectable dependency
  UserRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;
  
  // ✗ Bad: Direct singleton usage
  // final _firestore = FirebaseFirestore.instance;
}
```

## Troubleshooting

### Build Runner Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Import Issues
- Ensure all generated files have correct part directives
- Check that imports use correct relative paths
- Verify package names match in pubspec.yaml

### Firebase/Supabase Connection Issues
- Verify Firebase/Supabase is initialized in main.dart
- Check configuration files (google-services.json, .env)
- Verify authentication is set up if required

## Final Checklist

Before presenting the feature to the user:

- [ ] All models created with Freezed
- [ ] Code generation completed successfully
- [ ] Abstract repository interface defined
- [ ] Repository implementation completed
- [ ] State management (Riverpod/Bloc) set up
- [ ] UI screens created or integrated
- [ ] Navigation configured
- [ ] Error handling implemented
- [ ] Loading states handled
- [ ] Feature tested manually
- [ ] Code passes `flutter analyze`

## Communication Tips

When implementing features:
1. **Start with overview**: Explain the plan before coding
2. **Show progress**: Update user after each phase
3. **Ask for clarification**: Don't assume database schema or requirements
4. **Provide context**: Explain WHY you're doing something, not just WHAT
5. **Offer alternatives**: If multiple approaches exist, explain trade-offs
6. **Test thoroughly**: Verify feature works before marking as complete

Remember: Quality over speed. A well-structured feature is easier to maintain and extend.
