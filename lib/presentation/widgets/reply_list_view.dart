import 'package:fcms_helpdesk/domain/reply.dart';
import 'package:fcms_helpdesk/presentation/widgets/reply_list_item.dart';
import 'package:flutter/material.dart';
class ReplyListView extends StatelessWidget {
  final List<Reply> replies;
  const ReplyListView({super.key, required this.replies});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: replies.length,
      itemBuilder: (context, index) => ReplyListItem(reply: replies[index]),
      separatorBuilder: (context, index) => const Divider(height: 1),
    );
  }
}