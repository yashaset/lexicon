import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lexicon/features/entries/widgets/entries_header.dart';

import '../providers/entry_creation_provider.dart';
import 'entry_list.dart';
import 'new_entry_button.dart';
import 'new_entry_input.dart';

class EntriesPane extends ConsumerWidget {
  const EntriesPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCreatingEntry = ref.watch(entryCreationProvider);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Align(alignment: Alignment.centerLeft, child: EntriesHeader()),
        ),

        const Expanded(child: EntryList()),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: isCreatingEntry
              ? Padding(
                  key: const ValueKey('input'),
                  padding: const EdgeInsets.all(16),
                  child: NewEntryInput(
                    onFinished: () {
                      ref.read(entryCreationProvider.notifier).finish();
                    },
                  ),
                )
              : Padding(
                  key: const ValueKey('button'),
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: NewEntryButton(
                      onPressed: () {
                        ref.read(entryCreationProvider.notifier).start();
                      },
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
