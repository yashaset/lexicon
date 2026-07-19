class Book {
  const Book({required this.id, required this.title, this.entryCount = 0});

  final String id;
  final String title;
  final int entryCount;

  Book copyWith({String? id, String? title, int? entryCount}) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      entryCount: entryCount ?? this.entryCount,
    );
  }
}
