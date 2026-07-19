import 'package:flutter/material.dart';
import 'package:lexicon/shared/widgets/section_title.dart';
import '../../../shared/widgets/search_field.dart';
import 'book_list.dart';

class BooksSidebar extends StatefulWidget {
  const BooksSidebar({super.key});

  @override
  State<BooksSidebar> createState() => _BooksSidebarState();
}

class _BooksSidebarState extends State<BooksSidebar> {
  bool isCreatingBook = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Lexicon',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'BOOKS',
                    style: theme.textTheme.labelLarge?.copyWith(
                      letterSpacing: 1.4,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: isCreatingBook
                      ? null
                      : () {
                    setState(() {
                      isCreatingBook = true;
                    });
                  },
                  icon: const Icon(Icons.add, size: 18),
                  splashRadius: 18,
                  tooltip: 'New Book',
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SearchField(
              hintText: 'Search books',
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: BookList(
              isCreatingBook: isCreatingBook,
              onFinished: () {
                setState(() {
                  isCreatingBook = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
