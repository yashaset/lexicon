import 'package:flutter/material.dart';

import '../models/book.dart';
import 'book_tile_container.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.book,
    this.selected = false,
    this.onTap,
    this.onRename,
    this.onDelete,
  });

  final Book book;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onRename;
  final VoidCallback? onDelete;

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
                    color: theme.colorScheme.secondaryContainer,
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

                MenuAnchor(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: onRename,
                      child: const Text('Rename'),
                    ),
                    const Divider(height: 1),
                    MenuItemButton(
                      onPressed: onDelete,
                      child: const Text('Delete'),
                    ),
                  ],
                  builder: (context, controller, child) {
                    return IconButton(
                      icon: const Icon(Icons.more_horiz_rounded, size: 18),
                      visualDensity: VisualDensity.compact,
                      splashRadius: 16,
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
