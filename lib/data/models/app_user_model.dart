import 'package:fcms_helpdesk/core/enums/user_roles_enum.dart';
import 'package:fcms_helpdesk/domain/app_user.dart';

class AppUserModel {
  final String id;
  final String email;
  final String role;
  final String createdAt;

  const AppUserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {

    if (json['id'] == null) {
      throw const FormatException(
        'Missing required field: "id" in AppUserModel JSON.',
      );
    }
    if (json['email'] == null) {
      throw const FormatException(
        'Missing required field: "email" in AppUserModel JSON.',
      );
    }
    if (json['role'] == null) {
      throw const FormatException(
        'Missing required field: "role" in AppUserModel JSON.',
      );
    }
    if (json['created_at'] == null) {
      throw const FormatException(
        'Missing required field: "created_at" in AppUserModel JSON.',
      );
    }

    return AppUserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  AppUser toEntity() {
    return AppUser(
      id: id,
      email: email,
      role: role == 'admin' ? UserRole.admin : UserRole.staff,
    );
  }
}
