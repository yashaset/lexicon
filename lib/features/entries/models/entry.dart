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


  bool get isComplete {
    return (meaning?.trim().isNotEmpty ?? false) &&
        (example?.trim().isNotEmpty ?? false);
  }

  Entry copyWith({
    String? id,
    String? bookId,
    String? word,
    String? meaning,
    String? example,
    String? notes,
    bool? isNew,
  }) {
    return Entry(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      word: word ?? this.word,
      meaning: meaning ?? this.meaning,
      example: example ?? this.example,
      notes: notes ?? this.notes,
      isNew: isNew ?? this.isNew,
    );
  }
}
