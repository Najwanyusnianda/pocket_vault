import 'package:drift/drift.dart';
import 'documents_table.dart';
import 'bundles_table.dart';

class BundleDocuments extends Table {
  @override
  Set<Column> get primaryKey => {documentId, bundleId};

  // No onDelete parameter here
  IntColumn get documentId => integer().references(Documents, #id)();
  IntColumn get bundleId => integer().references(Bundles, #id)();

  DateTimeColumn get dateAdded => dateTime().withDefault(currentDateAndTime)();
}