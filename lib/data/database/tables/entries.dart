import 'package:drift/drift.dart';

class Entries extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get bookId => integer()();

  TextColumn get word => text()();

  TextColumn get meaning => text().nullable()();

  TextColumn get example => text().nullable()();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}