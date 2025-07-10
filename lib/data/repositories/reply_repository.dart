import 'package:fcms_helpdesk/core/constants/error_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fcms_helpdesk/data/models/reply_model.dart';
import 'package:fcms_helpdesk/domain/reply.dart';
import 'package:fcms_helpdesk/core/exceptions/app_exceptions.dart';

final replyRepositoryProvider = Provider<ReplyRepository>((ref) {
  return ReplyRepository();
});

class ReplyRepository {
  final _supabase = Supabase.instance.client;

  Future<void> createReply(String ticketId, String content) async {
    final response = await _supabase.rpc(
      'create_reply',
      params: {'p_ticket_id': ticketId, 'p_content': content},
    );

    final bool success = response['success'] as bool;
    final String? code = response['code'] as String?;
    final String? message = response['message'] as String?;

    if (!success) {
      throw switch (code) {
        ErrorCodes.unauthenticated => const UnauthenticatedException(),
        ErrorCodes.ticketNotFound => TicketNotFoundException(ticketId),
        ErrorCodes.permissionDenied => const PermissionDeniedException(),
        ErrorCodes.unknownException => UnknownErrorException(message),
        _ => UnknownErrorException(message ?? 'Failed to create reply.'),
      };
    }
  }

  Future<List<Reply>> getRepliesForTicket(String ticketId) async {
    final response = await _supabase.rpc(
      'get_replies_for_ticket',
      params: {'p_ticket_id': ticketId},
    );

    final bool success = response['success'] as bool;
    final String? code = response['code'] as String?;
    final String? message = response['message'] as String?;

    if (!success) {
      throw switch (code) {
        ErrorCodes.ticketNotFound => TicketNotFoundException(ticketId),
        ErrorCodes.unknownException => UnknownErrorException(message),
        _ => UnknownErrorException(
          message ?? 'Failed to fetch replies for ticket.',
        ),
      };
    }

    final List<dynamic> replyData = response['data'];
    final models = replyData.map((json) => ReplyModel.fromJson(json)).toList();
    return models.map((replyModel) => replyModel.toEntity()).toList();
  }
}
