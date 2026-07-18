import 'package:flutter/material.dart';

import '../models/entry.dart';

class EntryTile extends StatelessWidget {
  const EntryTile({
    super.key,
    required this.entry,
  });

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(entry.word),
      subtitle: Text(entry.meaning ?? ''),
      trailing: entry.isNew
          ? Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'NEW',
          style: TextStyle(fontSize: 11),
        ),
      )
          : null,
    );
  }
}