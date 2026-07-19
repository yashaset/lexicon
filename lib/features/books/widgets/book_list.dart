import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/books_provider.dart';
import 'book_tile.dart';
import 'new_book_input.dart';

class BookList extends ConsumerWidget {
  const BookList({
    super.key,
    required this.isCreatingBook,
    required this.onFinished,
  });

  final bool isCreatingBook;
  final VoidCallback onFinished;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(booksProvider);

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: state.books.length + (isCreatingBook ? 1 : 0),
      itemBuilder: (context, index) {
        if (isCreatingBook && index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: NewBookInput(onFinished: onFinished),
          );
        }

        final book = state.books[isCreatingBook ? index - 1 : index];

        return BookTile(
          book: book,
          selected: book.id == state.selectedBookId,
          onTap: () {
            ref.read(booksProvider.notifier).selectBook(book.id);
          },
        );
      },
    );
  }
}
