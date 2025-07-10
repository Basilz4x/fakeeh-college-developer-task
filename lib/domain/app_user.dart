import 'package:fcms_helpdesk/core/enums/user_roles_enum.dart';

class AppUser {
  final String id;
  final String email; 
  final UserRole role;

  const AppUser({
    required this.id,
    required this.email, 
    required this.role,
  });
}