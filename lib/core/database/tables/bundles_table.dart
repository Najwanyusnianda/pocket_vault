import 'package:drift/drift.dart';

class Bundles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get iconName => text().nullable()(); // For a custom icon e.g., 'car', 'travel'
  TextColumn get color => text().nullable()(); // Hex color code string
  DateTimeColumn get creationDate => dateTime()();
}
