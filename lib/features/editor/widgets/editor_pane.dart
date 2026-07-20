import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexicon/app/theme/app_colors.dart';
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
    final theme = Theme.of(context);

    if (entry == null) {
      _currentEntryId = null;

      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 56,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 24),
            Text(
              'No word selected',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a word from the list\nor press ⌘N to create one.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.outline,
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
      padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 56),
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Document title.
              AppTextField(
                controller: _wordController,
                focusNode: _wordFocusNode,
                autofocus: true,
                hintText: 'Untitled',
                textStyle: theme.textTheme.headlineLarge?.copyWith(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
                onChanged: (value) => notifier.updateWord(entry.id, value),
              ),

              const SizedBox(height: 40),

              // Meaning reads as the document's lead paragraph.
              _buildBlock(
                label: 'Meaning',
                controller: _meaningController,
                hint: 'What does it mean?',
                textStyle: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
                onChanged: (value) => notifier.updateMeaning(entry.id, value),
              ),

              const SizedBox(height: 40),

              // Example styled as a blockquote.
              _buildBlock(
                label: 'Example',
                controller: _exampleController,
                hint: 'Use it in a sentence…',
                blockquote: true,
                textStyle: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  height: 1.6,
                  color: AppColors.textSecondary,
                ),
                onChanged: (value) => notifier.updateExample(entry.id, value),
              ),

              const SizedBox(height: 40),

              // Notes flow as free-form body text.
              _buildBlock(
                label: 'Notes',
                controller: _notesController,
                hint: 'Anything worth remembering…',
                textStyle: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
                onChanged: (value) => notifier.updateNotes(entry.id, value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlock({
    required String label,
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required String hint,
    TextStyle? textStyle,
    bool blockquote = false,
  }) {
    final theme = Theme.of(context);
    final style = textStyle ?? theme.textTheme.bodyLarge;

    final field = TextField(
      controller: controller,
      onChanged: onChanged,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      cursorColor: AppColors.accent,
      style: style,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: style?.copyWith(color: theme.colorScheme.outline),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isCollapsed: true,
        contentPadding: EdgeInsets.zero,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Lightweight document heading — not a form label.
        Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        if (blockquote)
          Container(
            padding: const EdgeInsets.only(left: 18),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: AppColors.accent, width: 3),
              ),
            ),
            child: field,
          )
        else
          field,
      ],
    );
  }
}
