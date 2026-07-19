import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexicon/core/command_palette/command_list_controller.dart';

import '../command_palette_controller.dart';
import 'command_tile.dart';

class CommandList extends ConsumerWidget {
  const CommandList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commandPaletteProvider);

    final controller = CommandListController(
      context: context,
      query: state.query,
    );

    final filtered = controller.commands;

    if (filtered.isEmpty) {
      return const Center(
        child: Text('No matching commands', style: TextStyle(fontSize: 15)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return CommandTile(
          command: filtered[index],
          selected: index == state.selectedIndex,
        );
      },
    );
  }
}
