import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/book.dart';
import '../providers/book_rename_provider.dart';
import '../providers/books_provider.dart';

class RenameBookInput extends ConsumerStatefulWidget {
  const RenameBookInput({
    super.key,
    required this.book,
    required this.onFinished,
  });

  final Book book;
  final VoidCallback onFinished;

  @override
  ConsumerState<RenameBookInput> createState() =>
      _RenameBookInputState();
}

class _RenameBookInputState
    extends ConsumerState<RenameBookInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.book.title,
    );

    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: widget.book.title.length,
    );

    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _controller.text.trim();

    if (title.isEmpty) {
      ref.read(bookRenameProvider.notifier).state = null;
      widget.onFinished();
      return;
    }

    await ref.read(booksProvider.notifier).renameBook(
      id: widget.book.id,
      title: title,
    );

    ref.read(bookRenameProvider.notifier).state = null;
    widget.onFinished();
  }

  void _cancel() {
    ref.read(bookRenameProvider.notifier).state = null;
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Book name',
          border: InputBorder.none,
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _save(),
        onTapOutside: (_) => _cancel(),
      ),
    );
  }
}