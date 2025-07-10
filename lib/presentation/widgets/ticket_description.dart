import 'package:fcms_helpdesk/domain/ticket.dart';
import 'package:flutter/material.dart';

class TicketDescription extends StatelessWidget {
  final Ticket ticket;
  const TicketDescription({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.4),
            ),
          ),
          child: Text(ticket.description, style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
