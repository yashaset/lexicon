class Entry {
  const Entry({
    required this.id,
    required this.bookId,
    required this.word,
    this.meaning,
    this.example,
    this.notes,
    this.isNew = true,
  });

  final String id;
  final String bookId;

  final String word;

  final String? meaning;
  final String? example;
  final String? notes;

  final bool isNew;

  bool get isComplete => meaning != null && example != null;
}
