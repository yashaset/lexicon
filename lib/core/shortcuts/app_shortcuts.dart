import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../command_palette/command_palette_controller.dart';

class AppShortcuts extends ConsumerStatefulWidget {
  const AppShortcuts({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppShortcuts> createState() => _AppShortcutsState();
}

class _AppShortcutsState extends ConsumerState<AppShortcuts> {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyK, meta: true):
            OpenCommandPaletteIntent(),

        SingleActivator(LogicalKeyboardKey.escape): CloseCommandPaletteIntent(),
      },
      child: Actions(
        actions: {

          OpenCommandPaletteIntent:

          CallbackAction<OpenCommandPaletteIntent>(

            onInvoke: (intent) {

              ref.read(commandPaletteProvider.notifier).open();

              return null;

            },

          ),

          CloseCommandPaletteIntent:

          CallbackAction<CloseCommandPaletteIntent>(

            onInvoke: (intent) {

              ref.read(commandPaletteProvider.notifier).close();

              return null;

            },

          ),

        },
        child: Focus(autofocus: true, child: widget.child),
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
