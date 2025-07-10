import 'package:fcms_helpdesk/core/constants/error_constants.dart';
import 'package:fcms_helpdesk/core/enums/ticket_status_enum.dart';
import 'package:fcms_helpdesk/data/models/ticket_model.dart';
import 'package:fcms_helpdesk/domain/ticket.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fcms_helpdesk/core/exceptions/app_exceptions.dart';

final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  return TicketRepository();
});

class TicketRepository {
  final _supabase = Supabase.instance.client;

  Future<List<Ticket>> getTickets() async {
    final response = await _supabase.rpc('get_tickets');

    final bool success = response['success'] as bool;
    final String? code = response['code'] as String?;
    final String? message = response['message'] as String?;

    if (!success) {
      throw switch (code) {
        ErrorCodes.unauthenticated => const UnauthenticatedException(),
        ErrorCodes.userNotFound => const UserNotFoundException(),
        ErrorCodes.unknownException => UnknownErrorException(message),

        _ => UnknownErrorException(message ?? 'Failed to fetch tickets.'),
      };
    }

    final List<dynamic> ticketData = response['data'];
    final ticketModels =
        ticketData.map((json) => TicketModel.fromJson(json)).toList();
    return ticketModels.map((ticketModel) => ticketModel.toEntity()).toList();
  }

  Future<void> createTicket(String title, String description) async {
    final response = await _supabase.rpc(
      'create_ticket',
      params: {'p_title': title, 'p_description': description},
    );

    final bool success = response['success'] as bool;
    final String? code = response['code'] as String?;
    final String? message = response['message'] as String?;

    if (!success) {
      throw switch (code) {
        ErrorCodes.unauthenticated => const UnauthenticatedException(),
        ErrorCodes.ticketAlreadyExists => const TicketAlreadyExistsException(),
        ErrorCodes.unknownException => UnknownErrorException(message),
        // CORRECTED: Removed 'code: code' as UnknownErrorException doesn't accept it
        _ => UnknownErrorException(message ?? 'Failed to create ticket.'),
      };
    }
  }

  Future<Ticket> getTicketById(String ticketId) async {
    final response = await _supabase.rpc(
      'get_ticket_by_id',
      params: {'p_ticket_id': ticketId},
    );

    final bool success = response['success'] as bool;
    final String? code = response['code'] as String?;
    final String? message = response['message'] as String?;

    if (!success) {
      throw switch (code) {
        ErrorCodes.ticketNotFound => TicketNotFoundException(ticketId),
        ErrorCodes.unknownException => UnknownErrorException(message),
        _ => UnknownErrorException(message ?? 'Failed to fetch ticket by ID.'),
      };
    }

    final Map<String, dynamic> ticketData = response['data'];
    final ticketModel = TicketModel.fromJson(ticketData);
    return ticketModel.toEntity();
  }

  Future<List<Ticket>> searchTickets(String searchTerm) async {
    final response = await _supabase.rpc(
      'search_tickets',
      params: {'p_search_term': searchTerm},
    );

    final bool success = response['success'] as bool;
    final String? code = response['code'] as String?;
    final String? message = response['message'] as String?;

    if (!success) {
      throw switch (code) {
        ErrorCodes.unauthenticated => const UnauthenticatedException(),
        ErrorCodes.userNotFound => const UserNotFoundException(),
        ErrorCodes.unknownException => UnknownErrorException(message),
        // CORRECTED: Removed 'code: code' as UnknownErrorException doesn't accept it
        _ => UnknownErrorException(message ?? 'Search failed.'),
      };
    }

    final List<dynamic> ticketData = response['data'];
    final ticketModels =
        ticketData.map((json) => TicketModel.fromJson(json)).toList();
    return ticketModels.map((ticketModel) => ticketModel.toEntity()).toList();
  }

  Future<void> updateTicketStatus(
    String ticketId,
    TicketStatus newStatus,
  ) async {
    final statusString = newStatus.name;
    final response = await _supabase.rpc(
      'update_ticket_status',
      params: {'p_ticket_id': ticketId, 'p_new_status': statusString},
    );

    final bool success = response['success'] as bool;
    final String? code = response['code'] as String?;
    final String? message = response['message'] as String?;

    if (!success) {
      throw switch (code) {
        ErrorCodes.permissionDenied => const PermissionDeniedException(),
        ErrorCodes.ticketNotFound => TicketNotFoundException(ticketId),
        ErrorCodes.unknownException => UnknownErrorException(message),
        _ => UnknownErrorException(
          message ?? 'Failed to update ticket status.',
        ),
      };
    }
  }
}
