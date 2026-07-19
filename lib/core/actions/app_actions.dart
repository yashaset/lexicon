import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/entries/providers/entry_creation_provider.dart';
import '../../features/entries/providers/new_entry_focus_provider.dart';

class AppActions {
  const AppActions._();

  static void createEntry(
      BuildContext context,
      WidgetRef ref,
      ) {
    ref
        .read(entryCreationProvider.notifier)
        .start();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(newEntryFocusProvider.notifier)
          .requestFocus();
    });
  }
}