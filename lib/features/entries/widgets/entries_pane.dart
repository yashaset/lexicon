import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexicon/shared/widgets/section_title.dart';
import '../providers/entry_creation_provider.dart';
import 'entry_list.dart';

class EntriesPane extends ConsumerWidget {
  const EntriesPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCreatingEntry = ref.watch(entryCreationProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SectionTitle(
            "Entries",
            trailing: IconButton(
              onPressed: isCreatingEntry
                  ? null
                  : () {
                      ref.read(entryCreationProvider.notifier).start();
                    },
              icon: const Icon(Icons.add, size: 16),
              tooltip: "New Entry",
              visualDensity: VisualDensity.compact,
              splashRadius: 16,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 28, height: 28),
            ),
          ),
        ),

        Expanded(
          child: EntryList(
            isCreatingEntry: isCreatingEntry,
            onFinished: () {
              ref.read(entryCreationProvider.notifier).finish();
            },
          ),
        ),
      ],
    );
  }
}
