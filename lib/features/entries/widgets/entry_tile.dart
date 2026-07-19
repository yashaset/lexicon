import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/entry.dart';
import '../providers/entries_provider.dart';

class EntryTile extends ConsumerStatefulWidget {
  const EntryTile({super.key, required this.entry});

  final Entry entry;

  @override
  ConsumerState<EntryTile> createState() => _EntryTileState();
}

class _EntryTileState extends ConsumerState<EntryTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final selectedEntryId = ref.watch(
      entriesProvider.select((state) => state.selectedEntryId),
    );

    final isSelected = selectedEntryId == widget.entry.id;

    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              ref.read(entriesProvider.notifier).selectEntry(widget.entry.id);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isSelected
                    ? colorScheme.primaryContainer
                    : _isHovered
                    ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                    : Colors.transparent,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.entry.word,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          (widget.entry.meaning?.isNotEmpty ?? false)
                              ? widget.entry.meaning!
                              : 'No meaning yet',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),

                  if (widget.entry.isComplete)
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
      ),
    );
  }
}
