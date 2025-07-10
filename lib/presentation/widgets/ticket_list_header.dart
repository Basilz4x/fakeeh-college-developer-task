import 'package:flutter/material.dart';

class TicketListHeader extends StatelessWidget {
  const TicketListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final headerStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),

      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text('TITLE', style: headerStyle)),
          Expanded(flex: 3, child: Text('SUBMITTED BY', style: headerStyle)),
          Expanded(flex: 2, child: Text('CREATED AT', style: headerStyle)),
          Expanded(flex: 1, child: Text('STATUS', style: headerStyle)),
        ],
      ),
    );
  }
}
