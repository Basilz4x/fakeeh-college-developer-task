import 'package:fcms_helpdesk/core/enums/ticket_status_enum.dart';
import 'package:fcms_helpdesk/core/providers/user_role_provider.dart';
import 'package:fcms_helpdesk/presentation/controllers/ticket_details_page_controller.dart';
import 'package:fcms_helpdesk/presentation/widgets/add_reply_bar.dart';
import 'package:fcms_helpdesk/presentation/widgets/admin_status_button.dart';
import 'package:fcms_helpdesk/presentation/widgets/helpdesk_shell.dart';
import 'package:fcms_helpdesk/presentation/widgets/reply_section.dart';
import 'package:fcms_helpdesk/presentation/widgets/ticket_description.dart';
import 'package:fcms_helpdesk/presentation/widgets/ticket_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketDetailPage extends ConsumerWidget {
  final String ticketId;
  const TicketDetailPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketAsync = ref.watch(ticketDetailPageControllerProvider(ticketId));
    final userRole = ref.watch(userRoleProvider);

    return HelpdeskShell(
      child: ticketAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (err, stack) => Center(child: Text('Error loading ticket: $err')),
        data: (ticket) {
          final bool canReply =
              userRole == 'admin' || ticket.status == TicketStatus.Open;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24.0),
                  children: [
                    TicketHeader(ticket: ticket),
                    if (userRole == 'admin') ...[
                      const SizedBox(height: 16),
                      AdminStatusButton(ticket: ticket),
                    ],
                    const SizedBox(height: 24),
                    TicketDescription(ticket: ticket),
                    const SizedBox(height: 24),
                    Text(
                      'Replies',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ReplySection(ticketId: ticketId),
                  ],
                ),
              ),
              if (canReply) AddReplyBar(ticketId: ticketId),
            ],
          );
        },
      ),
    );
  }
}
