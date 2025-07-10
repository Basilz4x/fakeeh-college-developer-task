import 'package:fcms_helpdesk/presentation/controllers/all_tickets_page_controller.dart';
import 'package:fcms_helpdesk/presentation/pages/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcms_helpdesk/presentation/widgets/helpdesk_shell.dart';
import 'package:fcms_helpdesk/presentation/widgets/ticket_list_view.dart';

class AllTicketsPage extends ConsumerWidget {
  const AllTicketsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsAsync = ref.watch(allTicketsPageControllerProvider);

    return HelpdeskShell(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ticketsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) {
            debugPrint(err.toString());
            return ErrorPage(
              onRetry: () => ref.invalidate(allTicketsPageControllerProvider),
            );
          },
          data:
              (tickets) => TicketListView(
                tickets: tickets,
                onRefresh:
                    () => ref.invalidate(allTicketsPageControllerProvider),
              ),
        ),
      ),
    );
  }
}
