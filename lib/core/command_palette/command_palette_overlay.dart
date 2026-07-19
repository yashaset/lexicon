import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'command_list_controller.dart';
import 'command_palette_controller.dart';
import 'command_palette_intents.dart';
import 'widgets/command_list.dart';
import 'widgets/command_palette_search_field.dart';

class CommandPaletteOverlay extends ConsumerStatefulWidget {
  const CommandPaletteOverlay({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<CommandPaletteOverlay> createState() =>
      _CommandPaletteOverlayState();
}

class _CommandPaletteOverlayState extends ConsumerState<CommandPaletteOverlay> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commandPaletteProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.isOpen && !_focusNode.hasFocus) {
        _focusNode.requestFocus();
      }
    });

    return Stack(
      children: [
        widget.child,

        if (state.isOpen)
          Positioned.fill(
            child: ColoredBox(color: Colors.black.withValues(alpha: 0.15)),
          ),

        AnimatedPositioned(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          top: state.isOpen ? 80 : -500,
          left: 0,
          right: 0,
          child: IgnorePointer(
            ignoring: !state.isOpen,
            child: Center(
              child: Material(
                elevation: 18,
                borderRadius: BorderRadius.circular(18),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: 640,
                  height: 420,
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.surface,
                    child: Shortcuts(
                      shortcuts: const {
                        SingleActivator(LogicalKeyboardKey.arrowDown):
                            CommandPaletteNextIntent(),
                        SingleActivator(LogicalKeyboardKey.arrowUp):
                            CommandPalettePreviousIntent(),
                        SingleActivator(LogicalKeyboardKey.enter):
                            CommandPaletteExecuteIntent(),
                      },
                      child: Actions(
                        actions: {
                          CommandPaletteNextIntent:
                              CallbackAction<CommandPaletteNextIntent>(
                                onInvoke: (_) {
                                  final controller = CommandListController(
                                    context: context,
                                    ref: ref,
                                    query: state.query,
                                  );

                                  ref
                                      .read(commandPaletteProvider.notifier)
                                      .moveSelectionDown(
                                        controller.commands.length,
                                      );

                                  return null;
                                },
                              ),

                          CommandPalettePreviousIntent:
                              CallbackAction<CommandPalettePreviousIntent>(
                                onInvoke: (_) {
                                  ref
                                      .read(commandPaletteProvider.notifier)
                                      .moveSelectionUp();

                                  return null;
                                },
                              ),

                          CommandPaletteExecuteIntent:
                              CallbackAction<CommandPaletteExecuteIntent>(
                                onInvoke: (_) async {
                                  final controller = CommandListController(
                                    context: context,
                                    ref: ref,
                                    query: state.query,
                                  );

                                  await controller.execute(
                                    context,
                                    state.selectedIndex,
                                  );

                                  ref
                                      .read(commandPaletteProvider.notifier)
                                      .close();

                                  return null;
                                },
                              ),
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              child: CommandPaletteSearchField(
                                controller: _controller,
                                focusNode: _focusNode,
                                onChanged: (value) {
                                  ref
                                      .read(commandPaletteProvider.notifier)
                                      .updateQuery(value);
                                },
                              ),
                            ),

                            Divider(
                              height: 1,
                              color: Theme.of(
                                context,
                              ).dividerColor.withValues(alpha: 0.2),
                            ),

                            const Expanded(child: CommandList()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
