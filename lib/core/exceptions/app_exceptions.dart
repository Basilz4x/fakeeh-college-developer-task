import 'package:fcms_helpdesk/core/constants/error_constants.dart';

abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, {this.code});

  @override
  String toString() {
    if (code != null) {
      return 'AppException [$code]: $message';
    }
    return 'AppException: $message';
  }
}

class UnauthenticatedException extends AppException {
  const UnauthenticatedException()
    : super(
        'You are not authenticated. Please log in.',
        code: ErrorCodes.unauthenticated,
      );
}

class UserNotFoundException extends AppException {
  const UserNotFoundException()
    : super('User profile not found.', code: ErrorCodes.userNotFound);
}

class PermissionDeniedException extends AppException {
  const PermissionDeniedException()
    : super(
        'You do not have permission to perform this action.',
        code: ErrorCodes.permissionDenied,
      );
}

class UnknownErrorException extends AppException {
  const UnknownErrorException([String? message])
    : super(
        message ?? 'An unexpected error occurred.',
        code: ErrorCodes.unknownException,
      );
}

class TicketAlreadyExistsException extends AppException {
  const TicketAlreadyExistsException()
    : super(
        'A ticket with this title already exists for your account.',
        code: ErrorCodes.ticketAlreadyExists,
      );
}

class TicketNotFoundException extends AppException {
  const TicketNotFoundException([String? ticketId])
    : super(
        ticketId != null
            ? 'Ticket with ID $ticketId not found.'
            : 'The specified ticket was not found.',
        code: ErrorCodes.ticketNotFound,
      );
}

class InvalidLoginCredentialsException extends AppException {
  const InvalidLoginCredentialsException()
    : super(
        'Invalid email or password.',
        code: ErrorCodes.invalidLoginCredentials,
      );
}

class WeakPasswordException extends AppException {
  const WeakPasswordException()
    : super(
        'Password must be at least 6 characters.',
        code: ErrorCodes.weakPassword,
      );
}

class EmailAlreadyInUseException extends AppException {
  const EmailAlreadyInUseException()
    : super('Email already in use.', code: ErrorCodes.emailExists);
}

class PostgrestConnectionException extends AppException {
  const PostgrestConnectionException()
    : super(
        'Please check your internet connection.',
        code: ErrorCodes.postgrestConnectionError,
      );
}
