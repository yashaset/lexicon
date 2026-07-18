import 'package:flutter/material.dart';

import '../../../shared/widgets/section_title.dart';
import 'entry_list.dart';
import 'new_entry_button.dart';

class EntriesPane extends StatefulWidget {
  const EntriesPane({super.key});

  @override
  State<EntriesPane> createState() => _EntriesPaneState();
}

class _EntriesPaneState extends State<EntriesPane> {
  bool isCreatingEntry = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SectionTitle('Entries'),
          ),
        ),

        const Expanded(
          child: EntryList(),
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: isCreatingEntry
              ? Padding(
            key: const ValueKey('input'),
            padding: const EdgeInsets.all(16),
            child: const SizedBox.shrink(),
          )
              : Padding(
            key: const ValueKey('button'),
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: NewEntryButton(
                onPressed: () {
                  setState(() {
                    isCreatingEntry = true;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}