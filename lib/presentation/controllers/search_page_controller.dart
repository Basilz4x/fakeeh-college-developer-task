
import 'package:fcms_helpdesk/data/repositories/ticket_repository.dart';
import 'package:fcms_helpdesk/domain/ticket.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchPageControllerProvider =
    AsyncNotifierProvider<SearchPageController, List<Ticket>>(() {
  return SearchPageController();
});

class SearchPageController extends AsyncNotifier<List<Ticket>> {
  @override
  Future<List<Ticket>> build() async {
    return [];
  }

  Future<void> searchTickets(String searchTerm) async {
    if (searchTerm.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() {
      final ticketRepository = ref.read(ticketRepositoryProvider);
      return ticketRepository.searchTickets(searchTerm);
    });
  }
}