/// Custom exception classes for MoniKid app.
/// These are thrown by data sources and caught in repositories.

// =============================================================================
// BASE EXCEPTION
// =============================================================================

/// Base class for all app exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

// =============================================================================
// NETWORK EXCEPTIONS
// =============================================================================

/// Exception thrown when there is no internet connection
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Không có kết nối mạng',
    super.code = 'NETWORK_ERROR',
    super.originalError,
  });
}

/// Exception thrown when server returns an error
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    super.message = 'Lỗi máy chủ',
    super.code = 'SERVER_ERROR',
    super.originalError,
    this.statusCode,
  });
}

/// Exception thrown when request times out
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Yêu cầu quá thời gian',
    super.code = 'TIMEOUT_ERROR',
    super.originalError,
  });
}

// =============================================================================
// AUTH EXCEPTIONS
// =============================================================================

/// Exception thrown when authentication fails
class AuthException extends AppException {
  const AuthException({
    super.message = 'Lỗi xác thực',
    super.code = 'AUTH_ERROR',
    super.originalError,
  });
}

/// Exception thrown when user is not authenticated
class UnauthenticatedException extends AppException {
  const UnauthenticatedException({
    super.message = 'Chưa đăng nhập',
    super.code = 'UNAUTHENTICATED',
    super.originalError,
  });
}

/// Exception thrown when user doesn't have permission
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Không có quyền truy cập',
    super.code = 'UNAUTHORIZED',
    super.originalError,
  });
}

// =============================================================================
// CACHE EXCEPTIONS
// =============================================================================

/// Exception thrown when cache operation fails
class CacheException extends AppException {
  const CacheException({
    super.message = 'Lỗi bộ nhớ đệm',
    super.code = 'CACHE_ERROR',
    super.originalError,
  });
}

// =============================================================================
// VALIDATION EXCEPTIONS
// =============================================================================

/// Exception thrown when input validation fails
class ValidationException extends AppException {
  const ValidationException({
    super.message = 'Dữ liệu không hợp lệ',
    super.code = 'VALIDATION_ERROR',
    super.originalError,
  });
}
