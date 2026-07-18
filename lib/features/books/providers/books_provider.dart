import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/book.dart';
import '../models/books_state.dart';
import '../models/dummy_books.dart';

class BooksNotifier extends Notifier<BooksState> {
  @override
  BooksState build() {
    return BooksState(
      books: List.of(dummyBooks),
      selectedBookId: dummyBooks.isNotEmpty ? dummyBooks.first.id : null,
    );
  }

  void selectBook(String id) {
    state = state.copyWith(
      selectedBookId: id,
    );
  }

  void addBook(String title) {
    final book = Book(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );

    state = state.copyWith(
      books: [
        ...state.books,
        book,
      ],
      selectedBookId: book.id,
    );
  }
}

final booksProvider = NotifierProvider<BooksNotifier, BooksState>(
  BooksNotifier.new,
);