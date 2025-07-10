class ErrorCodes {
  ErrorCodes._(); 

  // General RPC errors
  static const String unauthenticated = 'UNAUTHENTICATED';
  static const String userNotFound = 'USER_NOT_FOUND'; // 
  static const String permissionDenied = 'PERMISSION_DENIED';
  static const String unknownException = 'UNKNOWN_EXCEPTION'; 

  // Ticket-specific errors
  static const String ticketAlreadyExists = 'TICKET_ALREADY_EXISTS';
  static const String ticketNotFound = 'TICKET_NOT_FOUND';

  // Supabase specific errors (from AuthException or PostgrestException)
  static const String invalidLoginCredentials = 'invalid_credentials';
  static const String weakPassword = 'weak_password';
  static const String emailExists = 'email_exists'; 
  static const String userAlreadyExists = 'user_already_exists'; 
  static const String postgrestConnectionError = 'PGRST116'; 
}
