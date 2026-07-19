import 'package:flutter/material.dart';

abstract final class AppAnimation {
  static const fast = Duration(milliseconds: 120);
  static const normal = Duration(milliseconds: 180);
  static const slow = Duration(milliseconds: 250);

  static const curve = Curves.easeOutCubic;
}