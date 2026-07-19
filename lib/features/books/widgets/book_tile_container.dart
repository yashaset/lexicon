import 'package:flutter/material.dart';
import 'package:lexicon/app/theme/app_colors.dart';

class BookTileContainer extends StatelessWidget {
  const BookTileContainer({
    super.key,
    required this.child,
    this.selected = false,
    this.onTap,
  });

  final Widget child;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: selected
            ? AppColors.accentLight
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          hoverColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha:
            .35,
          ),
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: child,
          ),
        ),
      ),
    );
  }
}
