import 'package:fcms_helpdesk/core/constants/error_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fcms_helpdesk/core/exceptions/app_exceptions.dart'; 

class ErrorHandler {
  static const _postgresErrorMessages = {
    ErrorCodes.postgrestConnectionError: 'Please check your internet connection (Postgrest).',
  };

  static const _authErrorMessages = {
    ErrorCodes.invalidLoginCredentials: 'Invalid email or password.',
    ErrorCodes.weakPassword: 'Password must be at least 6 characters.',
    ErrorCodes.emailExists: 'Email already in use.',
    ErrorCodes.userAlreadyExists: "Email already in use.", // Supabase sometimes uses this for existing email
    ErrorCodes.userNotFound: "Account not found.", // Supabase auth error for user not found
  };


  String getErrorMessage(Object error) {

    return switch (error) {
      // Handle custom AppExceptions directly
      AppException() => error.message,
      // Handle Supabase PostgrestException
      PostgrestException() => _getPostgresMessage(error),
      // Handle Supabase AuthException
      AuthException() => _getAuthMessage(error),
      // Fallback for any other unexpected errors
      _ => 'An unexpected error occurred. Please try again.',
    };
  }

  /// Maps PostgrestException codes to user-friendly messages.
  String _getPostgresMessage(PostgrestException error) {
    // Attempt to use the RPC code if available (e.g., from a thrown RPC error)
    if (error.code != null && _postgresErrorMessages.containsKey(error.code)) {
      return _postgresErrorMessages[error.code]!;
    }
    // Fallback to generic message or original message if no specific mapping
    return error.message ?? 'Database operation failed.';
  }

  /// Maps AuthException codes to user-friendly messages.
  String _getAuthMessage(AuthException error) {
    if (error.message != null) {
      // Supabase AuthException messages are often already user-friendly,
      // but we can override for specific codes if needed.
      if (_authErrorMessages.containsKey(error.message)) {
        return _authErrorMessages[error.message]!;
      }
      // Check by code if message is not directly in map
      if (error.code != null && _authErrorMessages.containsKey(error.code)) {
        return _authErrorMessages[error.code]!;
      }
    }
    return error.message ?? 'Authentication failed.';
  }
}

// Riverpod provider for ErrorHandler
final errorHandlerProvider = Provider<ErrorHandler>((ref) {
  return ErrorHandler();
});
