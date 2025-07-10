import 'package:fcms_helpdesk/presentation/widgets/navigation_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HelpdeskShell extends ConsumerWidget {
  final Widget child;

  const HelpdeskShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Row(
            children: [
              SizedBox(width: 250, child: NavigationPanel()),
              const VerticalDivider(width: 1, thickness: 1),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
