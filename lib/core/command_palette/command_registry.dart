import 'package:flutter/material.dart';

import 'command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/books/providers/book_creation_provider.dart';
import '../../features/entries/providers/new_entry_focus_provider.dart';
import '../../features/entries/providers/entry_creation_provider.dart';

class CommandRegistry {
  const CommandRegistry._();

  static List<Command> build(BuildContext context, WidgetRef ref) {
    return [
      Command(
        id: 'new-entry',
        title: 'New Entry',
        subtitle: 'Create a new vocabulary entry',
        icon: Icons.add_rounded,
        action: (_) async {
          ref.read(entryCreationProvider.notifier).start();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(newEntryFocusProvider.notifier).requestFocus();
          });
        },
      ),
      Command(
        id: 'new-book',
        title: 'New Book',
        subtitle: 'Create a new vocabulary book',
        icon: Icons.menu_book_rounded,
        action: (_) async {
          ref.read(bookCreationProvider.notifier).start();
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
