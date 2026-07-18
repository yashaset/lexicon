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
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void save() {
    final title = controller.text.trim();

    if (title.isEmpty) return;

    ref.read(booksProvider.notifier).addBook(title);

    controller.clear();
    ref.read(booksProvider.notifier).addBook(title);

    controller.clear();

    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      onEditingComplete: widget.onFinished,
      decoration: const InputDecoration(hintText: 'Book name'),
      onSubmitted: (_) => save(),
    );
  }
}
