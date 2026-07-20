import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookCreationNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void start() {
    state = true;
  }

  void finish() {
    state = false;
  }

  void toggle() {
    state = !state;
  }
}

final bookCreationProvider =
    NotifierProvider<BookCreationNotifier, bool>(BookCreationNotifier.new);
