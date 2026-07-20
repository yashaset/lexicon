import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/books/providers/book_creation_provider.dart';
import '../actions/app_actions.dart';
import '../command_palette/command_palette_controller.dart';
import 'app_intents.dart' hide OpenCommandPaletteIntent;

class AppShortcuts extends ConsumerWidget {
  const AppShortcuts({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shortcuts(
      shortcuts: const {
        SingleActivator(
          LogicalKeyboardKey.keyK,
          meta: true,
        ): OpenCommandPaletteIntent(),

        SingleActivator(
          LogicalKeyboardKey.keyN,
          meta: true,
        ): NewEntryIntent(),

        SingleActivator(
          LogicalKeyboardKey.keyB,
          meta: true,
        ): NewBookIntent(),

        SingleActivator(
          LogicalKeyboardKey.escape,
        ): CloseCommandPaletteIntent(),
      },
      child: Actions(
        actions: {
          OpenCommandPaletteIntent:
          CallbackAction<OpenCommandPaletteIntent>(
            onInvoke: (_) {
              ref.read(commandPaletteProvider.notifier).open();
              return null;
            },
          ),

          NewEntryIntent: CallbackAction<NewEntryIntent>(
            onInvoke: (_) {
              AppActions.createEntry(context, ref);
              return null;
            },
          ),

          NewBookIntent: CallbackAction<NewBookIntent>(
            onInvoke: (_) {
              ref.read(bookCreationProvider.notifier).start();
              return null;
            },
          ),

          CloseCommandPaletteIntent:
          CallbackAction<CloseCommandPaletteIntent>(
            onInvoke: (_) {
              ref.read(commandPaletteProvider.notifier).close();
              return null;
            },
          ),
        },
        child: FocusScope(
          autofocus: true,
          child: child,
        ),
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