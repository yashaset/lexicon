import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/books_provider.dart';
import 'book_tile_container.dart';

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

  bool _isSaving = false;

  void _save() {
    if (_isSaving) return;

    _isSaving = true;

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
    final theme = Theme.of(context);

    return BookTileContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.menu_book_outlined,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                hintText: "Untitled Book",
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _save(),
              onEditingComplete: _save,
              onTapOutside: (_) => _save(),
            ),
          ),
        ],
      ),
    );
  }
}
