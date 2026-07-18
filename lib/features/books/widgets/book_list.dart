import 'package:flutter/material.dart';

import '../models/dummy_books.dart';
import '../widgets/book_tile.dart';

class BookList extends StatelessWidget {
  const BookList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: dummyBooks.length,
      itemBuilder: (context, index) {
        return BookTile(
          book: dummyBooks[index],
          selected: index == 0,
        );
      },
    );
  }
}