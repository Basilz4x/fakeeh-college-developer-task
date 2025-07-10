import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcms_helpdesk/domain/reply.dart';
import 'package:fcms_helpdesk/data/repositories/reply_repository.dart';

final repliesControllerProvider =
    AutoDisposeAsyncNotifierProvider.family<ReplyController, List<Reply>, String>(() {
      return ReplyController();
    });

class ReplyController extends AutoDisposeFamilyAsyncNotifier<List<Reply>, String> {
  @override
  Future<List<Reply>> build(String ticketId) async {
    final replyRepository = ref.read(replyRepositoryProvider);
    return replyRepository.getRepliesForTicket(ticketId);
  }

  Future<void> addReply(String content) async {
    final ticketId = arg;
    final replyRepository = ref.read(replyRepositoryProvider);

    state = const AsyncValue.loading();

    try {
      await replyRepository.createReply(ticketId, content);
      ref.invalidateSelf();
      await future;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack); 
      rethrow;
    }
  }
}
