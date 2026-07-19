import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'command_palette_state.dart';

class CommandPaletteController extends Notifier<CommandPaletteState> {
  @override
  CommandPaletteState build() {
    return const CommandPaletteState();
  }

  void open() {
    state = state.copyWith(isOpen: true);
  }

  void close() {
    state = state.copyWith(isOpen: false, query: '', selectedIndex: 0);
  }

  void moveSelectionDown(int itemCount) {
    if (itemCount == 0) return;

    state = state.copyWith(
      selectedIndex: (state.selectedIndex + 1).clamp(0, itemCount - 1),
    );
  }

  void moveSelectionUp() {
    state = state.copyWith(
      selectedIndex: state.selectedIndex > 0 ? state.selectedIndex - 1 : 0,
    );
  }

  void resetSelection() {
    state = state.copyWith(selectedIndex: 0);
  }

  void updateQuery(String query) {
    state = state.copyWith(query: query, selectedIndex: 0);
  }
}

final commandPaletteProvider =
    NotifierProvider<CommandPaletteController, CommandPaletteState>(
      CommandPaletteController.new,
    );
