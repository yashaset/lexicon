import 'package:flutter/material.dart';

import 'command.dart';

class CommandRegistry {
  const CommandRegistry._();

  static List<Command> build(BuildContext context) {
    return [
      Command(
        id: 'new-entry',
        title: 'New Entry',
        subtitle: 'Create a new vocabulary entry',
        icon: Icons.add_rounded,
        action: (_) async {
          debugPrint('New Entry');
        },
      ),
      Command(
        id: 'new-book',
        title: 'New Book',
        subtitle: 'Create a new vocabulary book',
        icon: Icons.menu_book_rounded,
        action: (_) async {
          debugPrint('New Book');
        },
      ),
      Command(
        id: 'search',
        title: 'Search Entries',
        subtitle: 'Search your vocabulary',
        icon: Icons.search_rounded,
        action: (_) async {
          debugPrint('Search');
        },
      ),
      Command(
        id: 'settings',
        title: 'Settings',
        subtitle: 'Open application settings',
        icon: Icons.settings_rounded,
        action: (_) async {
          debugPrint('Settings');
        },
      ),
    ];
  }
}
