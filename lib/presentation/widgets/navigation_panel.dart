import 'package:fcms_helpdesk/core/constants/assets_constants.dart';
import 'package:fcms_helpdesk/core/providers/user_role_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fcms_helpdesk/presentation/widgets/navigation_item.dart';

class NavigationPanel extends ConsumerWidget {
  const NavigationPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(userRoleProvider);
    final String currentLocation = GoRouterState.of(context).matchedLocation;

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0, left: 8.0),
            child: Column(
              children: [
                SizedBox(height: 100, child: Image.asset(AppAssets.logo)),

                Text(
                  'FCMS Helpdesk',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          NavigationItem(
            title: userRole == 'admin' ? 'All Tickets' : 'My Tickets',
            icon: Icons.list_alt_rounded,
            isSelected: currentLocation == '/all-tickets',
            onTap: () => context.go('/all-tickets'),
          ),
          const SizedBox(height: 8),
          NavigationItem(
            title: 'Search',
            icon: Icons.search_rounded,
            isSelected: currentLocation == '/search',
            onTap: () => context.go('/search'),
          ),
          const SizedBox(height: 8),
          NavigationItem(
            title: 'Create New Ticket',
            icon: Icons.add_circle_outline_rounded,
            isSelected: currentLocation == '/create-ticket',
            onTap: () => context.go('/create-ticket'),
          ),
          const Divider(height: 32),
          NavigationItem(
            title: 'Settings',
            icon: Icons.settings_rounded,
            isSelected: currentLocation == '/settings',
            onTap: () => context.go('/settings'),
          ),
        ],
      ),
    );
  }
}
