import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/section_title.dart';
import '../providers/search_provider.dart';

class EntriesHeader extends ConsumerWidget {
  const EntriesHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Entries'),
          const SizedBox(height: 12),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search entries...',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              ref.read(searchQueryProvider.notifier).setQuery(value);
            },
          ),
        ],
      ),
    );
  }
}