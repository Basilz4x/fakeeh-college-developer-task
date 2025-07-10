import 'package:fcms_helpdesk/core/exceptions/error_handler.dart';
import 'package:fcms_helpdesk/presentation/controllers/settings_page_controller.dart';
import 'package:fcms_helpdesk/presentation/widgets/helpdesk_shell.dart';
import 'package:fcms_helpdesk/presentation/widgets/user_info_card.dart';
import 'package:fcms_helpdesk/presentation/widgets/appearance_settings_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   ref.listen<AsyncValue<void>>(settingsPageControllerProvider, (_, state) {
      state.whenOrNull(
        error: (error, stack) { 
          final errorHandler = ref.read(errorHandlerProvider);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorHandler.getErrorMessage(error)), 
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        },
        data: (_) {
          if (!state.isLoading && !state.hasError && context.mounted) {
            context.go('/login'); 
          }
        },
      );
    });

    final signOutState = ref.watch(settingsPageControllerProvider);

    return HelpdeskShell(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Text(
              'Settings',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            const UserInfoCard(),
            const SizedBox(height: 24),

            const AppearanceSettingsCard(),
            const SizedBox(height: 32),

            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 220),
                child:
                    signOutState
                            .isLoading 
                        ? const CircularProgressIndicator()
                        : ElevatedButton.icon(
                          onPressed: () {
                            ref
                                .read(settingsPageControllerProvider.notifier)
                                .signOut();
                          },
                          icon: const Icon(Icons.logout_rounded),
                          label: const Text('Sign Out'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            foregroundColor:
                                Theme.of(context).colorScheme.onError,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
