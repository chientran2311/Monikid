/// Failure classes for MoniKid app.
/// These represent domain-level errors returned by use cases/repositories.
/// Unlike exceptions, failures are values that can be pattern matched.

// =============================================================================
// BASE FAILURE
// =============================================================================

/// Base class for all failures
abstract class Failure {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  String toString() => 'Failure: $message (code: $code)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message && other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}

// =============================================================================
// NETWORK FAILURES
// =============================================================================

/// Failure when there is no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Không có kết nối mạng',
    super.code = 'NETWORK_ERROR',
  });
}

/// Failure when server returns an error
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Lỗi máy chủ',
    super.code = 'SERVER_ERROR',
  });
}

/// Failure when request times out
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    super.message = 'Yêu cầu quá thời gian',
    super.code = 'TIMEOUT_ERROR',
  });
}

// =============================================================================
// AUTH FAILURES
// =============================================================================

/// Failure when authentication fails
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Lỗi xác thực',
    super.code = 'AUTH_ERROR',
  });
}

/// Failure when user is not authenticated
class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure({
    super.message = 'Chưa đăng nhập',
    super.code = 'UNAUTHENTICATED',
  });
}

/// Failure when user doesn't have permission
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Không có quyền truy cập',
    super.code = 'UNAUTHORIZED',
  });
}

// =============================================================================
// CACHE FAILURES
// =============================================================================

/// Failure when cache operation fails
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Lỗi bộ nhớ đệm',
    super.code = 'CACHE_ERROR',
  });
}

// =============================================================================
// VALIDATION FAILURES
// =============================================================================

/// Failure when input validation fails
class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Dữ liệu không hợp lệ',
    super.code = 'VALIDATION_ERROR',
  });
}

// =============================================================================
// BUSINESS LOGIC FAILURES
// =============================================================================

/// Failure when a resource is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Không tìm thấy',
    super.code = 'NOT_FOUND',
  });
}

/// Failure when an operation is not allowed
class OperationNotAllowedFailure extends Failure {
  const OperationNotAllowedFailure({
    super.message = 'Thao tác không được phép',
    super.code = 'OPERATION_NOT_ALLOWED',
  });
}

/// Failure when balance is insufficient
class InsufficientBalanceFailure extends Failure {
  const InsufficientBalanceFailure({
    super.message = 'Số dư không đủ',
    super.code = 'INSUFFICIENT_BALANCE',
  });
}
