import 'package:flutter/material.dart';

import '../models/dummy_entries.dart';
import 'entry_tile.dart';

class EntryList extends StatelessWidget {
  const EntryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyEntries.length,
      itemBuilder: (_, index) {
        return EntryTile(
          entry: dummyEntries[index],
        );
      },
    );
  }
}