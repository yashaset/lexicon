import 'package:flutter/material.dart';

typedef CommandAction = Future<void> Function(BuildContext context);

class Command {
  const Command({
    required this.id,
    required this.title,
    required this.icon,
    required this.action,
    this.subtitle,
    this.keywords = const [],
  });

  final String id;
  final String title;
  final String? subtitle;
  final IconData icon;
  final List<String> keywords;

  final CommandAction action;
}