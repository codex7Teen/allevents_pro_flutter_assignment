enum ErrorType { network, authentication, notFound, timeout, parsing, unknown }

class UserFriendlyErrorMapper {
  /// Determines the error type based on the original error message
  static ErrorType getErrorType(String originalError) {
    if (originalError.contains('SocketException') ||
        originalError.contains('No Internet')) {
      return ErrorType.network;
    }
    if (originalError.contains('401') ||
        originalError.contains('Unauthorized')) {
      return ErrorType.authentication;
    }
    if (originalError.contains('404') || originalError.contains('Not Found')) {
      return ErrorType.notFound;
    }
    if (originalError.contains('TimeoutException')) {
      return ErrorType.timeout;
    }
    if (originalError.contains('FormatException') ||
        originalError.contains('parse error')) {
      return ErrorType.parsing;
    }
    return ErrorType.unknown;
  }

  /// Maps technical error messages to user-friendly messages
  static String mapErrorMessage(String originalError) {
    final errorType = getErrorType(originalError);

    switch (errorType) {
      case ErrorType.network:
        return 'Unable to connect to the internet. Please check your network connection.';
      case ErrorType.authentication:
        return 'Authentication failed. Please log in again.';
      case ErrorType.notFound:
        return 'The requested content could not be found.';
      case ErrorType.timeout:
        return 'The request took too long. Please try again later.';
      case ErrorType.parsing:
        return 'We encountered an issue processing the data. Please try again.';
      case ErrorType.unknown:
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Logs the original error for debugging while returning a user-friendly message
  static String logAndMapError(String originalError) {
    // TODO: Replace with actual logging mechanism
    print('Original Error: $originalError');
    return mapErrorMessage(originalError);
  }
}
