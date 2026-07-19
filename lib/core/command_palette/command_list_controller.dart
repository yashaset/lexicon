import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'command.dart';
import 'command_registry.dart';

class CommandListController {
  CommandListController({
    required this.context,
    required this.ref,
    required this.query,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String query;

  List<Command> get commands {
    final q = query.trim().toLowerCase();

    final allCommands = CommandRegistry.build(context, ref);

    if (q.isEmpty) {
      return allCommands;
    }

    return allCommands.where((command) {
      return command.title.toLowerCase().contains(q) ||
          (command.subtitle?.toLowerCase().contains(q) ?? false) ||
          command.keywords.any((keyword) => keyword.toLowerCase().contains(q));
    }).toList();
  }

  Future<void> execute(BuildContext context, int selectedIndex) async {
    final filtered = commands;

    if (filtered.isEmpty) {
      return;
    }

    if (selectedIndex < 0 || selectedIndex >= filtered.length) {
      return;
    }

    await filtered[selectedIndex].action(context);
  }
}
