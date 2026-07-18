import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../books/providers/books_provider.dart';
import '../providers/entries_provider.dart';

class NewEntryInput extends ConsumerStatefulWidget {
  const NewEntryInput({
    super.key,
    required this.onFinished,
  });

  final VoidCallback onFinished;

  @override
  ConsumerState<NewEntryInput> createState() => _NewEntryInputState();
}

class _NewEntryInputState extends ConsumerState<NewEntryInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _save() {
    final word = _controller.text.trim();

    if (word.isEmpty) {
      widget.onFinished();
      return;
    }

    final selectedBookId =
        ref.read(booksProvider).selectedBookId;

    if (selectedBookId == null) {
      widget.onFinished();
      return;
    }

    ref.read(entriesProvider.notifier).addEntry(
      bookId: selectedBookId,
      word: word,
    );

    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      decoration: const InputDecoration(
        hintText: 'German word...',
      ),
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => _save(),
    );
  }
}