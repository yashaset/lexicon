import 'package:flutter/material.dart';

class SidebarPane extends StatelessWidget {
  const SidebarPane({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: const Color(0xFFE8E1D6),
        border: Border(
          right: BorderSide(
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ),
      ),
      child: child,
    );
  }
}