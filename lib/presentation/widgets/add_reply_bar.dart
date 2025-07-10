import 'package:fcms_helpdesk/core/exceptions/error_handler.dart';
import 'package:fcms_helpdesk/presentation/controllers/reply_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddReplyBar extends ConsumerStatefulWidget {
  final String ticketId;
  const AddReplyBar({super.key, required this.ticketId});
  @override
  ConsumerState<AddReplyBar> createState() => _AddReplyBarState();
}

class _AddReplyBarState extends ConsumerState<AddReplyBar> {
  final _controller = TextEditingController();

  Future<void> _submit() async {
    if (_controller.text.trim().isEmpty) return;

    await ref
        .read(repliesControllerProvider(widget.ticketId).notifier)
        .addReply(_controller.text.trim());

    if (!ref.read(repliesControllerProvider(widget.ticketId)).hasError) {
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<dynamic>>>(
      repliesControllerProvider(widget.ticketId),
      (_, state) {
        state.whenOrNull(
          error: (error, stack) {
            final errorHandler = ref.read(errorHandlerProvider);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${errorHandler.getErrorMessage(error)}'),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      },
    );

    final replyState = ref.watch(repliesControllerProvider(widget.ticketId));

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type your reply...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          replyState.isLoading
              ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
              : IconButton.filled(
                icon: const Icon(Icons.send),
                onPressed: _submit,
              ),
        ],
      ),
    );
  }
}
