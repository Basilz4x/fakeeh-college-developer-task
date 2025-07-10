import 'package:fcms_helpdesk/core/providers/theme_controller.dart';
import 'package:fcms_helpdesk/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fcms_helpdesk/core/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(const ProviderScope(child: FcmsHelpdeskApp()));
}

class FcmsHelpdeskApp extends ConsumerWidget {
  const FcmsHelpdeskApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(routerProvider);
    final ThemeMode themeMode = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: 'FCMS Helpdesk',
      debugShowCheckedModeBanner: false,
      routerConfig: router,

      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,

      themeMode: themeMode,
    );
  }
}
