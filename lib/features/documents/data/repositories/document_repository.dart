//lib/features/documents/data/repositories/document_repository.dart
import 'dart:io';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/models/document_type.dart';

// This is the "contract". It defines what can be done with documents.
abstract class DocumentRepository {
  Stream<List<Document>> watchAllDocuments();
  Future<void> addDocument(DocumentsCompanion document);
  Future<void> updateDocument(DocumentsCompanion document);
  Future<void> deleteDocument(int id);
  Future<Document> getDocumentById(int id);
  Stream<Document> watchDocumentById(int id);
  Future<void> createDocumentWithFile({
    required String title,
    String? description,
    required File file,
    MainType? mainType,
    DateTime? expirationDate,
    bool isFavorite = false,
  });
}
