import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.indent = 0,
    this.endIndent = 0,
    this.opacity = 0.35,
  });

  final double indent;
  final double endIndent;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(
      context,
    ).dividerColor.withValues(alpha: opacity);

    return Divider(
      height: 1,
      thickness: 1,
      indent: indent,
      endIndent: endIndent,
      color: dividerColor,
    );
  }
}