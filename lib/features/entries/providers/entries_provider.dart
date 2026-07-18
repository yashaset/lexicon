import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dummy_entries.dart';
import '../models/entries_state.dart';
import '../models/entry.dart';

class EntriesNotifier extends Notifier<EntriesState> {
  @override
  EntriesState build() {
    return EntriesState(
      entries: List.of(dummyEntries),
    );
  }

  void addEntry(Entry entry) {
    state = state.copyWith(
      entries: [...state.entries, entry],
    );
  }

  void selectEntry(String id) {
    state = state.copyWith(
      selectedEntryId: id,
    );
  }
}

final entriesProvider =
NotifierProvider<EntriesNotifier, EntriesState>(
  EntriesNotifier.new,
);