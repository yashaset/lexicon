import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/search_field.dart';
import '../providers/book_creation_provider.dart';
import 'book_list.dart';

class BooksSidebar extends ConsumerWidget {
  const BooksSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isCreatingBook = ref.watch(bookCreationProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Lexicon',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'BOOKS',
                    style: theme.textTheme.labelLarge?.copyWith(
                      letterSpacing: 1.4,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: isCreatingBook
                      ? null
                      : () => ref.read(bookCreationProvider.notifier).start(),
                  icon: const Icon(Icons.add, size: 18),
                  splashRadius: 18,
                  tooltip: 'New Book',
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SearchField(
              hintText: 'Search books',
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: BookList(
              isCreatingBook: isCreatingBook,
              onFinished: () =>
                  ref.read(bookCreationProvider.notifier).finish(),
            ),
          ),
        ],
      ),
    );
  }
}
