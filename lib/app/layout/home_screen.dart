import 'package:flutter/material.dart';
import 'package:lexicon/features/books/widgets/books_sidebar.dart';
import 'package:lexicon/features/entries/widgets/entry_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 260,
            color: const Color(0xffE8E1D6),
            child: const Center(child: const BooksSidebar()),
          ),

          Container(
            width: 320,
            color: Colors.white,
            child: const Center(child: const Expanded(child: EntryList())),
          ),

          Expanded(
            child: Container(
              color: const Color(0xffF8F6F2),
              child: const Center(child: Text("Editor")),
            ),
          ),
        ],
      ),
    );
  }
}
