import 'package:flutter/material.dart';

class DetailPane extends StatelessWidget {
  const DetailPane({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F6F2),
      child: child,
    );
  }
}