import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
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

  Future<List<Book>> getBooks() {
    return select(books).get();
  }

  Future<int> createBook(String title) {
    return into(books).insert(BooksCompanion.insert(title: title));
  }

  Future<void> renameBook(int id, String title) {
    return (update(books)..where((b) => b.id.equals(id))).write(
      BooksCompanion(title: Value(title)),
    );
  }

  Future<void> deleteBook(int id) {
    return (delete(books)..where((b) => b.id.equals(id))).go();
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
