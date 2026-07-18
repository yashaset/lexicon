import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/entry.dart';
import '../providers/entries_provider.dart';

class EntryTile extends ConsumerWidget {
  const EntryTile({
    super.key,
    required this.entry,
  });

  final Entry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEntryId = ref.watch(
      entriesProvider.select((state) => state.selectedEntryId),
    );

    final isSelected = selectedEntryId == entry.id;

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            ref.read(entriesProvider.notifier).selectEntry(entry.id);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected
                  ? colorScheme.primaryContainer
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    entry.word,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),

                if (entry.isComplete)
                  Icon(
                    Icons.check_circle_rounded,
                    size: 16,
                    color: colorScheme.primary,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}