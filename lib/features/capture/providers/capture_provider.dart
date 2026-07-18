import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CaptureMode {
  none,
  newBook,
  newEntry,
}

class CaptureState {
  const CaptureState({
    this.mode = CaptureMode.none,
  });

  final CaptureMode mode;

  CaptureState copyWith({
    CaptureMode? mode,
  }) {
    return CaptureState(
      mode: mode ?? this.mode,
    );
  }
}

class CaptureNotifier extends Notifier<CaptureState> {
  @override
  CaptureState build() {
    return const CaptureState();
  }

  void newBook() {
    state = const CaptureState(
      mode: CaptureMode.newBook,
    );
  }

  void newEntry() {
    state = const CaptureState(
      mode: CaptureMode.newEntry,
    );
  }

  void cancel() {
    state = const CaptureState();
  }
}

final captureProvider =
NotifierProvider<CaptureNotifier, CaptureState>(
  CaptureNotifier.new,
);