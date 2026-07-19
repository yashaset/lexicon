import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookRenameNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void start(String bookId) {
    state = bookId;
  }

  void finish() {
    state = null;
  }
}

final bookRenameProvider =
NotifierProvider<BookRenameNotifier, String?>(
  BookRenameNotifier.new,
);