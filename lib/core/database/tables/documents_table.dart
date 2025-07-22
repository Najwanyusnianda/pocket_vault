import 'package:drift/drift.dart';

// We'll define bundles later, but we can reference it now.
import 'bundles_table.dart';

// This will be a simple Dart enum for document types
// We will create this file next.
import '../models/document_type.dart';

class Documents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().nullable()();
  
  // This path points to the actual encrypted file on the device
  TextColumn get filePath => text()(); 
  TextColumn get thumbnailPath => text().nullable()();

  // Store the enum as text in the database
  //TextColumn get documentType => text().map(const DocumentTypeConverter()).nullable()();
  TextColumn get mainType => text().map(const MainTypeConverter()).nullable()();
  TextColumn get subType => text().map(const SubTypeConverter()).nullable()();
  
  // Storing tags as a comma-separated string is simple and effective for MVP
  TextColumn get tags => text().nullable()();
  TextColumn get notes => text().nullable()();
  
  DateTimeColumn get creationDate => dateTime()();
  DateTimeColumn get updatedDate => dateTime()();
  DateTimeColumn get expirationDate => dateTime().nullable()();

  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
}
