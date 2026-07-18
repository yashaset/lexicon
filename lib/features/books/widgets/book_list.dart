import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/books_provider.dart';
import 'book_tile.dart';

class BookList extends ConsumerWidget {
  const BookList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(booksProvider);

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: state.books.length,
      itemBuilder: (context, index) {
        final book = state.books[index];

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