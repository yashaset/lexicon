import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database_provider.dart';
import '../models/book.dart';
import '../models/books_state.dart';

class BooksNotifier extends Notifier<BooksState> {
  @override
  BooksState build() {
    _loadBooks();

    return const BooksState(
      books: [],
      selectedBookId: null,
    );
  }

  Future<void> _loadBooks() async {
    final db = ref.read(databaseProvider);

    final rows = await db.getBooks();

    final books = rows
        .map(
          (b) => Book(
        id: b.id.toString(),
        title: b.title,
      ),
    )
        .toList();

    state = state.copyWith(
      books: books,
      selectedBookId: books.isEmpty ? null : books.first.id,
    );
  }

  void selectBook(String id) {
    state = state.copyWith(
      selectedBookId: id,
    );
  }

  Future<void> addBook(String title) async {
    final db = ref.read(databaseProvider);

    final id = await db.createBook(title);

    await _loadBooks();

    state = state.copyWith(
      selectedBookId: id.toString(),
    );
  }
}

final booksProvider =
NotifierProvider<BooksNotifier, BooksState>(BooksNotifier.new);