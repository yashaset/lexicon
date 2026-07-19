import 'package:flutter_riverpod/flutter_riverpod.dart';

class EntryCreationNotifier extends Notifier<bool> {
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

final entryCreationProvider =
NotifierProvider<EntryCreationNotifier, bool>(
  EntryCreationNotifier.new,
);