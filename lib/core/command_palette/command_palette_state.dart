class CommandPaletteState {
  const CommandPaletteState({
    this.isOpen = false,
    this.query = '',
    this.selectedIndex = 0,
  });

  final bool isOpen;
  final String query;
  final int selectedIndex;

  CommandPaletteState copyWith({
    bool? isOpen,
    String? query,
    int? selectedIndex,
  }) {
    return CommandPaletteState(
      isOpen: isOpen ?? this.isOpen,
      query: query ?? this.query,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}