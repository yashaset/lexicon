import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/books_provider.dart';

class NewBookInput extends ConsumerStatefulWidget {
  const NewBookInput({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  ConsumerState<NewBookInput> createState() => _NewBookInputState();
}

class _NewBookInputState extends ConsumerState<NewBookInput> {
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
    final title = _controller.text.trim();

    if (title.isEmpty) {
      widget.onFinished();
      return;
    }

    ref.read(booksProvider.notifier).addBook(title);

    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      autofocus: true,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      decoration: const InputDecoration(
        hintText: 'Untitled Book',
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      textInputAction: TextInputAction.done,
      onSubmitted: (_) => _save(),
      onEditingComplete: _save,
      onTapOutside: (_) => _save(),
    );
  }
}
