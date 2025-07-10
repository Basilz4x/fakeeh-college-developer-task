import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcms_helpdesk/data/repositories/ticket_repository.dart';

final createTicketPageControllerProvider =
    AsyncNotifierProvider<CreateTicketPageController, void>(
      CreateTicketPageController.new,
    );

class CreateTicketPageController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> createTicket(String title, String description) async {
    final ticketRepository = ref.read(ticketRepositoryProvider);

    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ticketRepository.createTicket(title, description),
    );
    return !state.hasError;
  }
}
