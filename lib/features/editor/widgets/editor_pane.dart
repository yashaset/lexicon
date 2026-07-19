import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexicon/core/widgets/app_divider.dart';
import 'package:lexicon/core/widgets/app_text_field.dart';
import 'package:lexicon/features/entries/models/entry.dart';

import '../../entries/providers/entries_provider.dart';

class EditorPane extends ConsumerStatefulWidget {
  const EditorPane({super.key});

  @override
  ConsumerState<EditorPane> createState() => _EditorPaneState();
}

class _EditorPaneState extends ConsumerState<EditorPane> {
  final _wordController = TextEditingController();
  final _wordFocusNode = FocusNode();
  final _meaningController = TextEditingController();
  final _exampleController = TextEditingController();
  final _notesController = TextEditingController();

  String? _currentEntryId;

  @override
  void dispose() {
    _wordController.dispose();
    _wordFocusNode.dispose();
    _meaningController.dispose();
    _exampleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _loadEntry(Entry entry) {
    _currentEntryId = entry.id;

    _wordController.value = TextEditingValue(
      text: entry.word,
      selection: TextSelection.collapsed(offset: entry.word.length),
    );

    _meaningController.value = TextEditingValue(
      text: entry.meaning ?? '',
      selection: TextSelection.collapsed(offset: (entry.meaning ?? '').length),
    );

    _exampleController.value = TextEditingValue(
      text: entry.example ?? '',
      selection: TextSelection.collapsed(offset: (entry.example ?? '').length),
    );

    _notesController.value = TextEditingValue(
      text: entry.notes ?? '',
      selection: TextSelection.collapsed(offset: (entry.notes ?? '').length),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _wordFocusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final entry = ref.watch(selectedEntryProvider);
    final notifier = ref.read(entriesProvider.notifier);

    if (entry == null) {
      _currentEntryId = null;

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 24),
            Text(
              'No word selected',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a word from the list\nor press ⌘N to create one.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    // Update controllers only when a different entry is selected.
    if (_currentEntryId != entry.id) {
      _loadEntry(entry);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 48),
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: _wordController,
                focusNode: _wordFocusNode,
                autofocus: true,
                // hintText: 'Word',
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
                onChanged: (value) {
                  ref
                      .read(entriesProvider.notifier)
                      .updateWord(entry.id, value);
                },
              ),

              const SizedBox(height: 40),

              _buildField(
                label: 'Meaning',
                controller: _meaningController,
                maxLines: 4,
                onChanged: (value) {
                  notifier.updateMeaning(entry.id, value);
                },
              ),

              const SizedBox(height: 24),

              _buildField(
                label: 'Example',
                controller: _exampleController,
                maxLines: 3,
                onChanged: (value) {
                  notifier.updateExample(entry.id, value);
                },
              ),

              const SizedBox(height: 24),

              _buildField(
                label: 'Notes',
                controller: _notesController,
                maxLines: 8,
                onChanged: (value) {
                  notifier.updateNotes(entry.id, value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: controller,
            onChanged: onChanged,
            maxLines: maxLines,
            decoration: const InputDecoration(
              hintText: 'Start typing...',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: theme.textTheme.bodyLarge,
          ),

          const SizedBox(height: 16),

          const AppDivider(),
        ],
      ),
    );
  }
}
