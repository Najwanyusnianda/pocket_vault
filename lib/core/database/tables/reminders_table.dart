import 'package:drift/drift.dart';
import 'documents_table.dart';

class Reminders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get documentId => integer().references(Documents, #id)();
  DateTimeColumn get reminderDate => dateTime()();
  DateTimeColumn get creationDate => dateTime()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get message => text().nullable()();
  BoolColumn get isDismissed => boolean().withDefault(const Constant(false))();
}
