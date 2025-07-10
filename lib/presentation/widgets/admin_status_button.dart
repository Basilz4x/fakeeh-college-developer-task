import 'package:fcms_helpdesk/core/enums/ticket_status_enum.dart';
import 'package:fcms_helpdesk/domain/ticket.dart';
import 'package:fcms_helpdesk/presentation/controllers/ticket_details_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminStatusButton extends ConsumerWidget {
  final Ticket ticket;
  const AdminStatusButton({super.key, required this.ticket});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketState = ref.watch(ticketDetailPageControllerProvider(ticket.id));
    final bool isOpen = ticket.status == TicketStatus.Open;
    final String buttonText = isOpen ? 'Mark as Closed' : 'Re-open Ticket';
    final IconData buttonIcon =
        isOpen ? Icons.check_circle_outline : Icons.lock_open_outlined;
    final Color buttonColor = isOpen ? Colors.green : Colors.orange;
    final TicketStatus newStatus =
        isOpen ? TicketStatus.Closed : TicketStatus.Open;

    if (ticketState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(buttonIcon),
        label: Text(buttonText),
        onPressed: () async {
          try {
            await ref
                .read(ticketDetailPageControllerProvider(ticket.id).notifier)
                .updateStatus(newStatus);
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $e'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}