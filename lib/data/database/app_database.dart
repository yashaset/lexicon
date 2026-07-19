import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:lexicon/data/database/book_with_count.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/books.dart';
import 'tables/entries.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Books, Entries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<BookWithCount>> getBooks() async {
    final allBooks = await select(books).get();

    final result = <BookWithCount>[];

    for (final book in allBooks) {
      final count =
          await (select(entries)..where((e) => e.bookId.equals(book.id)))
              .get()
              .then((rows) => rows.length);

      result.add(
        BookWithCount(id: book.id, title: book.title, entryCount: count),
      );
    }

    return result;
  }

  Future<int> createBook(String title) {
    return into(books).insert(BooksCompanion.insert(title: title));
  }

  Future<void> renameBook(int id, String title) {
    return (update(books)..where((b) => b.id.equals(id))).write(
      BooksCompanion(title: Value(title)),
    );
  }

  Future<void> deleteBook(int id) async {
    await (delete(entries)..where((e) => e.bookId.equals(id))).go();

    await (delete(books)..where((b) => b.id.equals(id))).go();
  }

  Future<List<Entry>> getEntries(int bookId) {
    return (select(entries)..where((e) => e.bookId.equals(bookId))).get();
  }

  Future<int> createEntry({required int bookId, required String word}) {
    return into(
      entries,
    ).insert(EntriesCompanion.insert(bookId: bookId, word: word));
  }

  Future<void> updateEntry({
    required int id,
    String? word,
    String? meaning,
    String? example,
    String? notes,
  }) {
    return (update(entries)..where((e) => e.id.equals(id))).write(
      EntriesCompanion(
        word: word == null ? const Value.absent() : Value(word),
        meaning: meaning == null ? const Value.absent() : Value(meaning),
        example: example == null ? const Value.absent() : Value(example),
        notes: notes == null ? const Value.absent() : Value(notes),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteEntry(int id) {
    return (delete(entries)..where((e) => e.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();

    await dir.create(recursive: true);

    final file = File(p.join(dir.path, 'lexicon.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
