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
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),

          SectionTitle(
            "Books",

            trailing: IconButton(
              onPressed: isCreatingBook
                  ? null
                  : () {
                      setState(() {
                        isCreatingBook = true;
                      });
                    },

              icon: const Icon(Icons.add, size: 16),

              tooltip: 'New Book',

              visualDensity: VisualDensity.compact,

              splashRadius: 16,

              padding: EdgeInsets.zero,

              constraints: const BoxConstraints.tightFor(width: 28, height: 28),
            ),
          ),
          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SearchField(hintText: 'Search books...'),
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
