import 'entry.dart';

class EntriesState {
  const EntriesState({required this.entries, this.selectedEntryId});

  final List<Entry> entries;
  final String? selectedEntryId;

  EntriesState copyWith({List<Entry>? entries, String? selectedEntryId}) {
    return EntriesState(
      entries: entries ?? this.entries,
      selectedEntryId: selectedEntryId ?? this.selectedEntryId,
    );
  }
}
