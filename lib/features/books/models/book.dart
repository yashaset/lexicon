class Book {
  const Book({
    required this.id,
    required this.title,
    this.entryCount = 0,
  });

  final String id;
  final String title;
  final int entryCount;
}