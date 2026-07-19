import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database_provider.dart';
import '../../books/providers/books_provider.dart';
import '../models/entries_state.dart';
import '../models/entry.dart';

class EntriesNotifier extends Notifier<EntriesState> {
  @override
  EntriesState build() {
    ref.listen(booksProvider, (previous, next) {
      if (previous?.selectedBookId != next.selectedBookId &&
          next.selectedBookId != null) {
        loadEntries(next.selectedBookId!);
      }
    });

    final selectedBookId = ref.read(booksProvider).selectedBookId;

    if (selectedBookId != null) {
      loadEntries(selectedBookId);
    }

    return const EntriesState(entries: [], selectedEntryId: null);
  }

  Future<void> loadEntries(String bookId) async {
    final db = ref.read(databaseProvider);

    final rows = await db.getEntries(int.parse(bookId));

    final entries = rows
        .map(
          (e) => Entry(
            id: e.id.toString(),
            bookId: e.bookId.toString(),
            word: e.word,
            meaning: e.meaning,
            example: e.example,
            notes: e.notes,
          ),
        )
        .toList();

    state = state.copyWith(
      entries: entries,
      selectedEntryId: entries.isEmpty ? null : entries.first.id,
    );
  }

  Future<void> addEntry({required String bookId, required String word}) async {
    final db = ref.read(databaseProvider);
    print('bookId = $bookId');
    final id = await db.createEntry(bookId: int.parse(bookId), word: word);
    print('inserted entry id = $id');
    await loadEntries(bookId);
    print('entries after load = ${state.entries.length}');
    state = state.copyWith(selectedEntryId: id.toString());
  }

  void selectEntry(String id) {
    state = state.copyWith(selectedEntryId: id);
  }

  Future<void> deleteEntry(String id) async {
    final db = ref.read(databaseProvider);

    await db.deleteEntry(int.parse(id));

    final bookId = ref.read(booksProvider).selectedBookId;

    if (bookId != null) {
      await loadEntries(bookId);
    }
  }

  Future<void> updateWord(String id, String value) async {
    await ref
        .read(databaseProvider)
        .updateEntry(id: int.parse(id), word: value);

    final bookId = ref.read(booksProvider).selectedBookId;

    if (bookId != null) {
      await loadEntries(bookId);
    }
  }

  Future<void> updateMeaning(String id, String value) async {
    await ref
        .read(databaseProvider)
        .updateEntry(id: int.parse(id), meaning: value);

    final bookId = ref.read(booksProvider).selectedBookId;

    if (bookId != null) {
      await loadEntries(bookId);
    }
  }

  Future<void> updateExample(String id, String value) async {
    await ref
        .read(databaseProvider)
        .updateEntry(id: int.parse(id), example: value);

    final bookId = ref.read(booksProvider).selectedBookId;

    if (bookId != null) {
      await loadEntries(bookId);
    }
  }

  Future<void> updateNotes(String id, String value) async {
    await ref
        .read(databaseProvider)
        .updateEntry(id: int.parse(id), notes: value);

    final bookId = ref.read(booksProvider).selectedBookId;

    if (bookId != null) {
      await loadEntries(bookId);
    }
  }

  void selectNextEntry() {
    final current = state.selectedEntryId;
    if (current == null) return;

    final index = state.entries.indexWhere((e) => e.id == current);

    if (index >= 0 && index < state.entries.length - 1) {
      state = state.copyWith(selectedEntryId: state.entries[index + 1].id);
    }
  }

  void selectPreviousEntry() {
    final current = state.selectedEntryId;
    if (current == null) return;

    final index = state.entries.indexWhere((e) => e.id == current);

    if (index > 0) {
      state = state.copyWith(selectedEntryId: state.entries[index - 1].id);
    }
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
    return state.entries.firstWhere((e) => e.id == state.selectedEntryId);
  } catch (_) {
    return null;
  }
});
