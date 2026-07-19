import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/entry.dart';
import '../providers/entries_provider.dart';
import 'package:lexicon/core/constants/app_animation.dart';
import 'package:lexicon/core/constants/app_radius.dart';
import 'package:lexicon/core/constants/app_spacing.dart';

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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.md),
            onTap: () {
              ref.read(entriesProvider.notifier).selectEntry(widget.entry.id);
            },
            child: AnimatedContainer(
              duration: AppAnimation.normal,
              curve: AppAnimation.curve,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.md),
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

                        const SizedBox(height: AppSpacing.xs),

                        Text(
                          (widget.entry.meaning?.isNotEmpty ?? false)
                              ? widget.entry.meaning!
                              : 'No meaning yet',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey.shade800,
                                fontStyle: FontStyle.italic,
                              ),
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
