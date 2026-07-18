import 'package:flutter/material.dart';
import 'package:lexicon/features/books/widgets/new_book_input.dart';
import 'package:lexicon/shared/widgets/section_title.dart';
import '../../../shared/widgets/search_field.dart';
import 'new_book_button.dart';
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

          const SectionTitle("Books"),

          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SearchField(hintText: 'Search books...'),
          ),

          const SizedBox(height: 16),

          const Expanded(child: BookList()),

          // AnimatedSwitcher(
          //   duration: const Duration(milliseconds: 180),
          //   child: isCreatingBook
          //       ? Padding(
          //           key: const ValueKey('input'),
          //           padding: const EdgeInsets.all(16),
          //           child: NewBookInput(
          //             onFinished: () {
          //               setState(() {
          //                 isCreatingBook = false;
          //               });
          //             },
          //           ),
          //         )
          //       : Padding(
          //           key: const ValueKey('button'),
          //           padding: const EdgeInsets.all(16),
          //           child: SizedBox(
          //             width: double.infinity,
          //             child: NewBookButton(),
          //           ),
          //         ),
          // ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),

            child: isCreatingBook
                ? Padding(
                    key: const ValueKey('input'),

                    padding: const EdgeInsets.all(16),

                    child: NewBookInput(
                      onFinished: () {
                        setState(() {
                          isCreatingBook = false;
                        });
                      },
                    ),
                  )
                : Padding(
                    key: const ValueKey('button'),

                    padding: const EdgeInsets.all(16),

                    child: SizedBox(
                      width: double.infinity,

                      child: NewBookButton(
                        onPressed: () {
                          setState(() {
                            isCreatingBook = true;
                          });
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
