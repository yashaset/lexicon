import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/database_provider.dart';
import '../models/book.dart';
import '../models/books_state.dart';

class BooksNotifier extends Notifier<BooksState> {
  @override
  BooksState build() {
    _loadBooks();

    return const BooksState(books: [], selectedBookId: null);
  }

  Future<void> _loadBooks() async {
    final db = ref.read(databaseProvider);

    final rows = await db.getBooks();

    final books = rows
        .map(
          (b) => Book(
            id: b.id.toString(),
            title: b.title,
            entryCount: b.entryCount,
          ),
        )
        .toList();

    state = state.copyWith(
      books: books,
      selectedBookId: books.isEmpty ? null : books.first.id,
    );
  }

  void selectBook(String id) {
    state = state.copyWith(selectedBookId: id);
  }

  Future<void> addBook(String title) async {
    final db = ref.read(databaseProvider);

    final id = await db.createBook(title);

    await _loadBooks();

    state = state.copyWith(selectedBookId: id.toString());
  }

  Future<void> renameBook({required String id, required String title}) async {
    final db = ref.read(databaseProvider);

    await db.renameBook(int.parse(id), title);

    await _loadBooks();
  }

  Future<void> deleteBook(String id) async {
    final db = ref.read(databaseProvider);

    await db.deleteBook(int.parse(id));

    await _loadBooks();

    final selected = state.selectedBookId;

    if (selected == id) {
      state = state.copyWith(
        selectedBookId: state.books.isEmpty ? null : state.books.first.id,
      );
    }
  }
}

final booksProvider = NotifierProvider<BooksNotifier, BooksState>(
  BooksNotifier.new,
);
