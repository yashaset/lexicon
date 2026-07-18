import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/entries_provider.dart';
import 'entry_tile.dart';


class EntryList extends ConsumerWidget {
  const EntryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(entriesProvider);

    if (entries.isEmpty) {
      return const Center(
        child: Text('No entries yet'),
      );
    }

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (_, index) {
        return EntryTile(
          entry: entries[index],
        );
      },
    );
  }
}