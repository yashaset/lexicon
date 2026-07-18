import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexicon/features/entries/models/entry.dart';

import '../../entries/providers/entries_provider.dart';

class EditorPane extends ConsumerStatefulWidget {
  const EditorPane({super.key});

  @override
  ConsumerState<EditorPane> createState() => _EditorPaneState();
}

class _EditorPaneState extends ConsumerState<EditorPane> {
  final _wordController = TextEditingController();
  final _meaningController = TextEditingController();
  final _exampleController = TextEditingController();
  final _notesController = TextEditingController();

  String? _currentEntryId;

  @override
  void dispose() {
    _wordController.dispose();
    _meaningController.dispose();
    _exampleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _loadEntry(Entry entry) {
    _currentEntryId = entry.id;

    _wordController.value = TextEditingValue(
      text: entry.word,
      selection: TextSelection.collapsed(
        offset: entry.word.length,
      ),
    );

    _meaningController.value = TextEditingValue(
      text: entry.meaning ?? '',
      selection: TextSelection.collapsed(
        offset: (entry.meaning ?? '').length,
      ),
    );

    _exampleController.value = TextEditingValue(
      text: entry.example ?? '',
      selection: TextSelection.collapsed(
        offset: (entry.example ?? '').length,
      ),
    );

    _notesController.value = TextEditingValue(
      text: entry.notes ?? '',
      selection: TextSelection.collapsed(
        offset: (entry.notes ?? '').length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entry = ref.watch(selectedEntryProvider);
    final notifier = ref.read(entriesProvider.notifier);

    if (entry == null) {
      _currentEntryId = null;

      return const Center(
        child: Text(
          'Select an entry to start editing.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    // Update controllers only when a different entry is selected.
    if (_currentEntryId != entry.id) {
      _loadEntry(entry);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildField(
            label: 'Word',
            controller: _wordController,
            onChanged: (value) {
              notifier.updateWord(entry.id, value);
            },
          ),

          const SizedBox(height: 24),

          _buildField(
            label: 'Meaning',
            controller: _meaningController,
            maxLines: 3,
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
            maxLines: 6,
            onChanged: (value) {
              notifier.updateNotes(entry.id, value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
