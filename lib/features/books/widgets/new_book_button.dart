import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/primary_button.dart';
import '../providers/books_provider.dart';

class NewBookButton extends ConsumerWidget {
  const NewBookButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PrimaryButton(
      label: 'New Book',
      icon: Icons.add,
      onPressed: () async {
        final controller = TextEditingController();

        final title = await showDialog<String>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('New Book'),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Book title',
              ),
              onSubmitted: (value) {
                Navigator.pop(context, value);
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context, controller.text);
                },
                child: const Text('Create'),
              ),
            ],
          ),
        );

        if (title == null || title.trim().isEmpty) return;

        ref.read(booksProvider.notifier).addBook(title.trim());
      },
    );
  }
}