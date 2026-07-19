import 'package:flutter/material.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "${book.entryCount} entries",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
