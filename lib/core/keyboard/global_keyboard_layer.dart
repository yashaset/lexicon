import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../command_palette/command_palette_controller.dart';

class GlobalKeyboardLayer extends ConsumerWidget {
  const GlobalKeyboardLayer({
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
        ): ActivateIntent(),
      },
      child: Actions(
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              ref.read(commandPaletteProvider.notifier).open();
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