import 'package:fcms_helpdesk/domain/reply.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReplyListItem extends StatelessWidget {
  final Reply reply;
  const ReplyListItem({super.key, required this.reply});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  reply.createdBy.email,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  DateFormat.yMd().add_jm().format(reply.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(reply.content, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
