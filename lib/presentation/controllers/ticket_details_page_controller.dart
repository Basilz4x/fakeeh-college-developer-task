import 'package:fcms_helpdesk/core/enums/ticket_status_enum.dart';
import 'package:fcms_helpdesk/data/repositories/ticket_repository.dart';
import 'package:fcms_helpdesk/domain/ticket.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final ticketDetailPageControllerProvider =
    AutoDisposeAsyncNotifierProvider.family<TicketDetailPageController, Ticket, String>(() {
  return TicketDetailPageController();
});

class TicketDetailPageController extends AutoDisposeFamilyAsyncNotifier<Ticket, String> {
  @override
  Future<Ticket> build(String ticketId) async {
    final ticketRepository = ref.read(ticketRepositoryProvider);
    return ticketRepository.getTicketById(ticketId);
  }

  Future<void> updateStatus(TicketStatus newStatus) async {
    final ticketId = arg; 
    final ticketRepository = ref.read(ticketRepositoryProvider);
    
    state = const AsyncValue.loading();

    try {
      await ticketRepository.updateTicketStatus(ticketId, newStatus);
      // Invalidate the provider to force a refetch of the ticket details again will show the new status,
      ref.invalidateSelf();
    } catch (e) {
      rethrow;
    }
  }
}