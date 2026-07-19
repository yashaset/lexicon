import 'package:flutter/material.dart';

import 'command.dart';
import 'command_registry.dart';

class CommandListController {
  CommandListController({required this.context, required this.query});

  final BuildContext context;
  final String query;

  List<Command> get commands {
    final q = query.trim().toLowerCase();

    final allCommands = CommandRegistry.build(context);

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
