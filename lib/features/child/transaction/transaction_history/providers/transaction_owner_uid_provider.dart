import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';

part 'transaction_owner_uid_provider.g.dart';

/// The uid whose transactions are being viewed.
///
/// Defaults to the authenticated user (child viewing their own data). The
/// parent transaction screen overrides this in a [ProviderScope] with the
/// selected child's uid, so the shared transaction providers/widgets query the
/// child's data without any change to the widget layer.
@riverpod
String? transactionOwnerUid(Ref ref) {
  final auth = ref.watch(authSessionProvider);
  return auth.isAuthenticated ? auth.user?.uid : null;
}
