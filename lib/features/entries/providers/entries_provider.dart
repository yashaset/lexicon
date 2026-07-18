import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../books/providers/books_provider.dart';
import '../models/dummy_entries.dart';

final entriesProvider = Provider((ref) {
  final booksState = ref.watch(booksProvider);

  final selectedId = booksState.selectedBookId;

  return dummyEntries
      .where((entry) => entry.bookId == selectedId)
      .toList();
});