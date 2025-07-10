import 'package:fcms_helpdesk/domain/ticket.dart';
import 'package:fcms_helpdesk/presentation/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketHeader extends StatelessWidget {
  final Ticket ticket;
  const TicketHeader({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Ticket: ${ticket.title}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            StatusChip(status: ticket.status),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Reference ID: ${ticket.referenceId}',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        Text(
          'Submitted by: ${ticket.createdBy.email}',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        Text(
          'Created at: ${DateFormat('dd MMM. - HH:mm').format(ticket.createdAt)}',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
