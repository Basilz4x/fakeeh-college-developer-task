import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcms_helpdesk/data/repositories/auth_repository.dart';
import 'package:fcms_helpdesk/presentation/controllers/user_profile_controller.dart';

final settingsPageControllerProvider =
    AsyncNotifierProvider<SettingsPageController, void>(
      SettingsPageController.new,
    );

class SettingsPageController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    ref.invalidate(userProfileControllerProvider);

    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signOut();
    });
  }
}
