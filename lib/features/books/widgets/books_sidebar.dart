import 'package:flutter/material.dart';
import 'package:lexicon/shared/widgets/section_title.dart';
import '../../../shared/widgets/search_field.dart';
import 'new_book_button.dart';
import 'book_list.dart';

class BooksSidebar extends StatelessWidget {
  const BooksSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),

          const SectionTitle("Books"),

          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SearchField(
              hintText: 'Search books...',
            ),
          ),

          const SizedBox(height: 16),

          const Expanded(
            child: BookList(),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: NewBookButton(
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}