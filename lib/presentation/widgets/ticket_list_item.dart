import 'package:fcms_helpdesk/domain/ticket.dart';
import 'package:flutter/material.dart';
import 'package:fcms_helpdesk/presentation/widgets/status_chip.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart'; 

class TicketListItem extends StatelessWidget {
  final Ticket ticket;
  const TicketListItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/tickets/${ticket.id}'); 
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(
                ticket.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                ticket.createdBy.email,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                DateFormat(
                  'dd MMM yyyy - HH:mm',
                ).format(ticket.createdAt), 
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
            Expanded(flex: 1, child: StatusChip(status: ticket.status)),
          ],
        ),
      ),
    );
  }
}
