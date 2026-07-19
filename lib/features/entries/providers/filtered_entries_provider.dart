import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../books/providers/books_provider.dart';
import '../models/entry.dart';
import 'entries_provider.dart';
import 'search_provider.dart';

final filteredEntriesProvider = Provider<List<Entry>>((ref) {
  final entriesState = ref.watch(entriesProvider);
  final booksState = ref.watch(booksProvider);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();

  final selectedBookId = booksState.selectedBookId;

  if (selectedBookId == null) {
    return [];
  }

  var entries = entriesState.entries.where(
        (entry) => entry.bookId == selectedBookId,
  );

  if (query.isNotEmpty) {
    entries = entries.where((entry) {
      return entry.word.toLowerCase().contains(query) ||
          (entry.meaning?.toLowerCase().contains(query) ?? false);
    });
  }
  return entries.toList();
});