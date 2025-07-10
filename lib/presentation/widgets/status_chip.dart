
import 'package:fcms_helpdesk/core/enums/ticket_status_enum.dart';
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final TicketStatus status;
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final bool isOpen = status == TicketStatus.Open;
    final Color chipColor = isOpen ? Colors.green : Colors.grey;
    final Color textColor = isOpen ? Colors.green[800]! : Colors.grey[800]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.name.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}