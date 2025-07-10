import 'package:fcms_helpdesk/domain/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcms_helpdesk/data/models/app_user_model.dart'; 

final appUserRepositoryProvider = Provider<AppUserRepository>((ref) {
  return AppUserRepository();
});

class AppUserRepository {
  final _supabase = Supabase.instance.client;

  Future<AppUser?> fetchUserProfile({required String userId}) async {
    final profileResponse =
        await _supabase.from('app_users').select().eq('id', userId).single();

    final appUserModel = AppUserModel.fromJson(profileResponse);

    return appUserModel.toEntity();
  }
}
