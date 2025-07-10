import 'package:fcms_helpdesk/presentation/controllers/user_profile_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRoleProvider = Provider<String>((ref) {
  final userProfile = ref.watch(userProfileControllerProvider);
  return userProfile.value?.role.name ?? 'staff';
});