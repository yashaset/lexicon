import 'package:flutter/material.dart';

class EditorSection extends StatelessWidget {
  const EditorSection({
    super.key,
    required this.title,
    required this.controller,
    required this.onChanged,
    this.maxLines = 4,
    this.hintText,
  });

  final String title;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            onChanged: onChanged,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              isCollapsed: true,
            ),
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          Divider(color: theme.dividerColor.withValues(alpha: 0.4), height: 1),
        ],
      ),
    );
  }
}
