import 'package:fcms_helpdesk/data/repositories/ticket_repository.dart';
import 'package:fcms_helpdesk/domain/ticket.dart';
import 'package:fcms_helpdesk/presentation/controllers/user_profile_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allTicketsPageControllerProvider =
    AsyncNotifierProvider<AllTicketsPageController, List<Ticket>>(
      AllTicketsPageController.new,
    );

class AllTicketsPageController extends AsyncNotifier<List<Ticket>> {
  @override
  Future<List<Ticket>> build() async {
    await ref.watch(userProfileControllerProvider.future);

    final ticketRepository = ref.read(ticketRepositoryProvider);
    return ticketRepository.getTickets();
  }
}
