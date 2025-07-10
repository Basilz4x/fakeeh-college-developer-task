
import 'dart:async';
import 'package:fcms_helpdesk/core/providers/user_provider.dart';
import 'package:fcms_helpdesk/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fcms_helpdesk/data/repositories/app_user_repository.dart';

final userProfileControllerProvider =
    AutoDisposeAsyncNotifierProvider<UserProfileController, AppUser?>(() {
  return UserProfileController();
});

class UserProfileController extends AutoDisposeAsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    final user = ref.watch(userProvider);

    if (user == null) {
      return null;
    }

    final appUserRepository = ref.read(appUserRepositoryProvider);
    return appUserRepository.fetchUserProfile(userId: user.id);
  }
}