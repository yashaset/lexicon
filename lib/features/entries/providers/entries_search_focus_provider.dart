import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final entriesSearchFocusNodeProvider = Provider<FocusNode>((ref) {
  final node = FocusNode();

  ref.onDispose(node.dispose);

  return node;
});