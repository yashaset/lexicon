import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexicon/features/books/providers/book_rename_provider.dart';
import 'package:lexicon/features/books/widgets/rename_book_input.dart';
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
    final renamingBookId = ref.watch(bookRenameProvider);
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

        return MenuAnchor(
          menuChildren: [
            MenuItemButton(
              onPressed: () {
                ref.read(bookRenameProvider.notifier).start(book.id);
              },
              child: const Text('Rename'),
            ),
            MenuItemButton(
              onPressed: () async {
                final confirmed = await showCupertinoDialog<bool>(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text('Delete Book'),
                      content: Text(
                        'Delete "${book.title}" and all its entries?',
                      ),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text('Cancel'),
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );

                if (confirmed == true) {
                  await ref.read(booksProvider.notifier).deleteBook(book.id);
                }
              },
              child: const Text('Delete'),
            ),
          ],
          builder: (context, controller, child) {
            if (renamingBookId == book.id) {
              return RenameBookInput(
                book: book,
                onFinished: () {
                  ref.read(bookRenameProvider.notifier).finish();
                },
              );
            }

            return GestureDetector(
              onSecondaryTapDown: (_) {
                controller.open();
              },
              child: BookTile(
                book: book,
                selected: book.id == state.selectedBookId,
                onTap: () {
                  ref.read(booksProvider.notifier).selectBook(book.id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
