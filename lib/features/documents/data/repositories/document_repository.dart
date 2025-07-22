//lib/features/documents/data/repositories/document_repository.dart
import '../../../../core/database/app_database.dart';

// This is the "contract". It defines what can be done with documents.
abstract class DocumentRepository {
  Stream<List<Document>> watchAllDocuments();
  Future<void> addDocument(DocumentsCompanion document);
  Future<void> updateDocument(DocumentsCompanion document);
  Future<void> deleteDocument(int id);
}
