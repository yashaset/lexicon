import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/search_provider.dart';
import '../../../core/shortcuts/app_intents.dart';
import '../providers/entries_provider.dart';
import '../providers/filtered_entries_provider.dart';
import 'entry_tile.dart';

class EntryList extends ConsumerStatefulWidget {
  const EntryList({super.key});

  @override
  ConsumerState<EntryList> createState() => _EntryListState();
}

class _EntryListState extends ConsumerState<EntryList> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(filteredEntriesProvider);

    final searchQuery = ref.watch(searchQueryProvider);

    if (entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 42,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 12),
            Text(
              searchQuery.isEmpty
                  ? 'No entries yet'
                  : 'No matching entries',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (searchQuery.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                'Try a different search term.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      );
    }

    return FocusableActionDetector(
      autofocus: true,
      focusNode: _focusNode,
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.arrowUp):
        PreviousEntryIntent(),
        SingleActivator(LogicalKeyboardKey.arrowDown):
        NextEntryIntent(),
      },
      actions: {
        NextEntryIntent: CallbackAction<NextEntryIntent>(
          onInvoke: (intent) {
            ref.read(entriesProvider.notifier).selectNextEntry();
            return null;
          },
        ),
        PreviousEntryIntent: CallbackAction<PreviousEntryIntent>(
          onInvoke: (intent) {
            ref.read(entriesProvider.notifier).selectPreviousEntry();
            return null;
          },
        ),
      },
      child: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (_, index) {
          return EntryTile(
            entry: entries[index],
          );
        },
      ),
    );
  }
}