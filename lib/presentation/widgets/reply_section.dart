import 'package:fcms_helpdesk/presentation/controllers/reply_controller.dart';
import 'package:fcms_helpdesk/presentation/widgets/reply_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReplySection extends ConsumerWidget {
  final String ticketId;
  const ReplySection({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repliesAsync = ref.watch(repliesControllerProvider(ticketId));
    return repliesAsync.when(
      loading:
          () => const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          ),
      error: (err, stack) => Center(child: Text('Error loading replies: $err')),
      data: (replies) {
        if (replies.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No replies yet.'),
            ),
          );
        }
        return ListView.separated(
          itemCount: replies.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => ReplyListItem(reply: replies[index]),
          separatorBuilder: (_, __) => const SizedBox(height: 8),
        );
      },
    );
  }
}
