import 'package:flutter/material.dart';
import 'package:lexicon/app/theme/app_colors.dart';

import '../models/book.dart';
import 'book_tile_container.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.book,
    this.selected = false,
    this.onTap,
  });

  final Book book;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BookTileContainer(
      selected: selected,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.menu_book_outlined,

            size: 18,

            color: theme.colorScheme.onSurfaceVariant,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentLight,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${book.entryCount}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
