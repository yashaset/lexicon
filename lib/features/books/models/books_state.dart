import 'book.dart';

class BooksState {
  const BooksState({
    required this.books,
    required this.selectedBookId,
  });

  final List<Book> books;
  final String? selectedBookId;

  BooksState copyWith({
    List<Book>? books,
    String? selectedBookId,
  }) {
    return BooksState(
      books: books ?? this.books,
      selectedBookId: selectedBookId ?? this.selectedBookId,
    );
  }
}