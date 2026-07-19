import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dummy_entries.dart';
import '../models/entries_state.dart';
import '../models/entry.dart';

class EntriesNotifier extends Notifier<EntriesState> {
  @override
  EntriesState build() {
    return EntriesState(entries: List.of(dummyEntries));
  }

  void addEntry({required String bookId, required String word}) {
    final entry = Entry(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      bookId: bookId,
      word: word,
    );

    state = state.copyWith(
      entries: [...state.entries, entry],
      selectedEntryId: entry.id,
    );
  }

  void selectEntry(String id) {
    state = state.copyWith(selectedEntryId: id);
  }

  void selectNextEntry() {
    final entries = state.entries;

    if (entries.isEmpty) return;

    final currentIndex = entries.indexWhere(
      (e) => e.id == state.selectedEntryId,
    );

    if (currentIndex == -1) {
      state = state.copyWith(selectedEntryId: entries.first.id);
      return;
    }

    if (currentIndex < entries.length - 1) {
      state = state.copyWith(selectedEntryId: entries[currentIndex + 1].id);
    }
  }

  void selectPreviousEntry() {
    final entries = state.entries;

    if (entries.isEmpty) return;

    final currentIndex = entries.indexWhere(
      (e) => e.id == state.selectedEntryId,
    );

    if (currentIndex == -1) {
      state = state.copyWith(selectedEntryId: entries.first.id);
      return;
    }

    if (currentIndex > 0) {
      state = state.copyWith(selectedEntryId: entries[currentIndex - 1].id);
    }
  }

  void deleteEntry(String id) {
    state = state.copyWith(
      entries: state.entries.where((e) => e.id != id).toList(),
      selectedEntryId: state.selectedEntryId == id
          ? null
          : state.selectedEntryId,
    );
  }

  void updateWord(String entryId, String value) {
    _updateEntry(entryId, (entry) => entry.copyWith(word: value));
  }

  void updateMeaning(String entryId, String value) {
    _updateEntry(entryId, (entry) => entry.copyWith(meaning: value));
  }

  void updateExample(String entryId, String value) {
    _updateEntry(entryId, (entry) => entry.copyWith(example: value));
  }

  void updateNotes(String entryId, String value) {
    _updateEntry(entryId, (entry) => entry.copyWith(notes: value));
  }

  void _updateEntry(String entryId, Entry Function(Entry entry) update) {
    state = state.copyWith(
      entries: state.entries.map((entry) {
        if (entry.id != entryId) {
          return entry;
        }

        return update(entry);
      }).toList(),
    );
  }
}

final entriesProvider = NotifierProvider<EntriesNotifier, EntriesState>(
  EntriesNotifier.new,
);

final selectedEntryProvider = Provider<Entry?>((ref) {
  final state = ref.watch(entriesProvider);

  if (state.selectedEntryId == null) {
    return null;
  }

  try {
    return state.entries.firstWhere(
      (entry) => entry.id == state.selectedEntryId,
    );
  } catch (_) {
    return null;
  }
});
