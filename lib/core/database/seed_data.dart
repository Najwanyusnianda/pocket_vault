import 'package:drift/drift.dart';
import 'package:pocket_vault/core/database/app_database.dart';
import 'package:pocket_vault/core/database/models/document_type.dart';

// A static class so we don't need to instantiate it.
class SeedData {
  // The main function that seeds all data.
  static Future<void> seedDatabase(AppDatabase db) async {
    // Check if documents already exist to prevent re-seeding on hot reloads.
    final count = await db.select(db.documents).get();
    if (count.isNotEmpty) {
      print('Database already seeded. Skipping.');
      return;
    }

    print('Seeding database with initial data...');
    await _seedDocuments(db);
    // You could add _seedBundles(db), etc. here later.
    print('Seeding complete.');
  }

  // A private helper to seed just the documents.
  static Future<void> _seedDocuments(AppDatabase db) async {
    final documentsToInsert = [
      DocumentsCompanion(
        title: const Value('Passport'),
        mainType: const Value(MainType.identification),
        subType: const Value(SubType.passport),
        filePath: const Value('placeholder/passport.jpg'),
        expirationDate: Value(DateTime.now().add(const Duration(days: 365 * 5))),
        creationDate: Value(DateTime.now()),
        updatedDate: Value(DateTime.now()),
        isFavorite: const Value(true),
      ),
      DocumentsCompanion(
        title: const Value('Driver\'s License'),
        mainType: const Value(MainType.vehicle),
        subType: const Value(SubType.driversLicense),
        filePath: const Value('placeholder/license.jpg'),
        expirationDate: Value(DateTime.now().add(const Duration(days: 730))),
        creationDate: Value(DateTime.now().subtract(const Duration(days: 50))),
        updatedDate: Value(DateTime.now().subtract(const Duration(days: 50))),
      ),
      DocumentsCompanion(
        title: const Value('Amex Platinum'),
        mainType: const Value(MainType.financial),
        subType: const Value(SubType.creditCard),
        filePath: const Value('placeholder/amex.jpg'),
        // No expiration date for this one
        creationDate: Value(DateTime.now().subtract(const Duration(days: 100))),
        updatedDate: Value(DateTime.now()),
        isArchived: const Value(true), // An archived document
      ),
      DocumentsCompanion(
        title: const Value('Car Insurance Policy'),
        mainType: const Value(MainType.vehicle),
        subType: const Value(SubType.carInsurance),
        filePath: const Value('placeholder/insurance.pdf'),
        expirationDate: Value(DateTime.now().add(const Duration(days: 180))),
        creationDate: Value(DateTime.now().subtract(const Duration(days: 200))),
        updatedDate: Value(DateTime.now().subtract(const Duration(days: 10))),
      ),
    ];

    // Use a batch insert for efficiency.
    await db.batch((batch) {
      batch.insertAll(db.documents, documentsToInsert);
    });
  }
}
