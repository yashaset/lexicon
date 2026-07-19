import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewEntryFocusNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void requestFocus() {
    state++;
  }
}

final newEntryFocusProvider = NotifierProvider<NewEntryFocusNotifier, int>(
  NewEntryFocusNotifier.new,
);
