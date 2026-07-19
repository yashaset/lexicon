import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../command_palette/command_palette_controller.dart';

class AppShortcuts extends ConsumerWidget {
  const AppShortcuts({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyK, meta: true):
            OpenCommandPaletteIntent(),

        SingleActivator(LogicalKeyboardKey.escape): CloseCommandPaletteIntent(),

        SingleActivator(LogicalKeyboardKey.arrowDown):
            CommandPaletteNextIntent(),

        SingleActivator(LogicalKeyboardKey.arrowUp):
            CommandPalettePreviousIntent(),

        SingleActivator(LogicalKeyboardKey.enter):
            CommandPaletteExecuteIntent(),
      },
      child: Actions(
        actions: {
          OpenCommandPaletteIntent: CallbackAction<OpenCommandPaletteIntent>(
            onInvoke: (intent) {
              ref.read(commandPaletteProvider.notifier).open();
              return null;
            },
          ),

          CloseCommandPaletteIntent: CallbackAction<CloseCommandPaletteIntent>(
            onInvoke: (intent) {
              ref.read(commandPaletteProvider.notifier).close();
              return null;
            },
          ),
          CommandPaletteNextIntent: CallbackAction<CommandPaletteNextIntent>(
            onInvoke: (intent) {
              // TODO: Move selection down

              return null;
            },
          ),

          CommandPalettePreviousIntent:
              CallbackAction<CommandPalettePreviousIntent>(
                onInvoke: (intent) {
                  // TODO: Move selection up

                  return null;
                },
              ),

          CommandPaletteExecuteIntent:
              CallbackAction<CommandPaletteExecuteIntent>(
                onInvoke: (intent) {
                  // TODO: Execute selected command

                  return null;
                },
              ),
        },
        child: Focus(autofocus: true, child: child),
      ),
    );
  }
}

class OpenCommandPaletteIntent extends Intent {
  const OpenCommandPaletteIntent();
}

class CloseCommandPaletteIntent extends Intent {
  const CloseCommandPaletteIntent();
}

class CommandPaletteNextIntent extends Intent {
  const CommandPaletteNextIntent();
}

class CommandPalettePreviousIntent extends Intent {
  const CommandPalettePreviousIntent();
}

class CommandPaletteExecuteIntent extends Intent {
  const CommandPaletteExecuteIntent();
}
