import 'package:fcms_helpdesk/core/providers/auth_state_changes_provider.dart';
import 'package:fcms_helpdesk/presentation/pages/all_tickets_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fcms_helpdesk/presentation/pages/login_page.dart';
import 'package:fcms_helpdesk/presentation/pages/create_ticket_page.dart';
import 'package:fcms_helpdesk/presentation/pages/search_page.dart';
import 'package:fcms_helpdesk/presentation/pages/settings_page.dart';
import 'package:fcms_helpdesk/presentation/pages/ticket_detail_page.dart';



final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/all-tickets',
        builder: (context, state) => const AllTicketsPage(),
      ),
      GoRoute(path: '/search', builder: (context, state) => const SearchPage()),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/create-ticket',
        builder: (context, state) => const CreateTicketPage(),
      ),

      GoRoute(
        path: '/tickets/:ticketId',
        builder: (context, state) {
          final ticketId = state.pathParameters['ticketId']!;
          return TicketDetailPage(ticketId: ticketId);
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = authState.value?.session != null;
      final bool onLoginPage = state.matchedLocation == '/login';

      if (!loggedIn) {
        return onLoginPage ? null : '/login';
      }
      if (onLoginPage) {
        return '/all-tickets';
      }
      return null;
    },
  );
});
