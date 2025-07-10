import 'package:fcms_helpdesk/domain/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcms_helpdesk/presentation/widgets/ticket_list_header.dart';
import 'package:fcms_helpdesk/presentation/widgets/ticket_list_item.dart';

class TicketListView extends ConsumerWidget {
  final List<Ticket> tickets;
  final VoidCallback onRefresh;

  const TicketListView({
    super.key,
    required this.tickets,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tickets',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh Tickets',
              onPressed: onRefresh,
            ),
          ],
        ),
        const SizedBox(height: 24),
        const TicketListHeader(),
        const Divider(),
        Expanded(
          child:
              tickets.isEmpty
                  ? const Center(
                    child: Text(
                      'No tickets found.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                  : ListView.separated(
                    itemCount: tickets.length,
                    itemBuilder:
                        (context, index) =>
                            TicketListItem(ticket: tickets[index]),
                    separatorBuilder:
                        (context, index) => const Divider(height: 1),
                  ),
        ),
      ],
    );
  }
}
