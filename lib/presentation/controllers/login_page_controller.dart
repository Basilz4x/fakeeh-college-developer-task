import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcms_helpdesk/data/repositories/auth_repository.dart';
import 'package:fcms_helpdesk/presentation/controllers/user_profile_controller.dart';

class LoginPageController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return ref.read(authRepositoryProvider).signIn(email, password);
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    // we do it here before the signout so the router wont send us to next page before invalidate the provider
    ref.invalidate(userProfileControllerProvider);

    state = await AsyncValue.guard(() {
      return ref.read(authRepositoryProvider).signOut();
    });
  }
}

final loginPageControllerProvider =
    AsyncNotifierProvider<LoginPageController, void>(LoginPageController.new);
