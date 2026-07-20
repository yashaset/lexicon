import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/search_provider.dart';
import '../../../core/shortcuts/app_intents.dart';
import '../providers/entries_provider.dart';
import '../providers/filtered_entries_provider.dart';
import 'entry_tile.dart';
import 'new_entry_input.dart';

class EntryList extends ConsumerStatefulWidget {
  const EntryList({
    super.key,
    required this.isCreatingEntry,
    required this.onFinished,
  });

  final bool isCreatingEntry;
  final VoidCallback onFinished;

  @override
  ConsumerState<EntryList> createState() => _EntryListState();
}

class _EntryListState extends ConsumerState<EntryList> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant EntryList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Entry creation just started: the input is inserted at the top of the
    // list, so scroll there to reveal it. Mounting it also triggers its
    // built-in auto-focus.
    if (!oldWidget.isCreatingEntry && widget.isCreatingEntry) {
      _scrollToTop();
    }
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(filteredEntriesProvider);

    final searchQuery = ref.watch(searchQueryProvider);

    if (entries.isEmpty && !widget.isCreatingEntry) {
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
              searchQuery.isEmpty ? 'No entries yet' : 'No matching entries',
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
        SingleActivator(LogicalKeyboardKey.arrowUp): PreviousEntryIntent(),
        SingleActivator(LogicalKeyboardKey.arrowDown): NextEntryIntent(),
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
        controller: _scrollController,
        itemCount: entries.length + (widget.isCreatingEntry ? 1 : 0),
        itemBuilder: (_, index) {
          if (widget.isCreatingEntry && index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: NewEntryInput(onFinished: widget.onFinished),
            );
          }

          final entry = entries[widget.isCreatingEntry ? index - 1 : index];

          return EntryTile(entry: entry);
        },
      ),
    );
  }
}
