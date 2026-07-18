import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../books/providers/books_provider.dart';
import '../models/entry.dart';
import 'entries_provider.dart';

final filteredEntriesProvider = Provider<List<Entry>>((ref) {
  final entriesState = ref.watch(entriesProvider);
  final booksState = ref.watch(booksProvider);

  final selectedBookId = booksState.selectedBookId;

  if (selectedBookId == null) {
    return [];
  }

  return entriesState.entries
      .where((entry) => entry.bookId == selectedBookId)
      .toList();
});