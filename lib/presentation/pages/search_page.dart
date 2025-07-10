import 'dart:async';
import 'package:fcms_helpdesk/presentation/pages/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcms_helpdesk/presentation/controllers/search_page_controller.dart';
import 'package:fcms_helpdesk/presentation/widgets/helpdesk_shell.dart';
import 'package:fcms_helpdesk/presentation/widgets/ticket_list_view.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  Timer? _debounce;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchPageControllerProvider.notifier).searchTickets(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResultsAsync = ref.watch(searchPageControllerProvider);

    return HelpdeskShell(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search Tickets',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              autofocus: true, 
              decoration: InputDecoration(
                hintText: 'Type to search by ticket title...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: searchResultsAsync.when(
                data: (tickets) {
                  if (_searchController.text.isEmpty) {
                    return const Center(
                      child: Text('Enter a search term to begin.'),
                    );
                  }
                  return TicketListView(
                    tickets: tickets,
                    onRefresh:
                        () => ref.invalidate(searchPageControllerProvider),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) {
                  debugPrint(err.toString());
                  return ErrorPage(
                    onRetry: () => ref.invalidate(searchPageControllerProvider),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
