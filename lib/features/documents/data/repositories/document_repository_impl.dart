// lib/features/documents/data/repositories/document_repository_impl.dart
import 'dart:io';
import 'package:path/path.dart' as p; // <-- FIX 1: Import for 'p' alias
import 'package:path_provider/path_provider.dart'; // <-- FIX 2: Import for getApplicationDocumentsDirectory
import 'package:drift/drift.dart' as drift;
import 'document_repository.dart';
import '../../../../core/database/daos/documents_dao.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/models/document_type.dart';
class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentsDao _documentsDao;

  DocumentRepositoryImpl(this._documentsDao);

  @override
  Stream<List<Document>> watchAllDocuments() {
    return _documentsDao.watchAllDocuments();
  }

  @override
  Future<void> addDocument(DocumentsCompanion document) {
    return _documentsDao.insertDocument(document);
  }

  @override
  Future<void> updateDocument(DocumentsCompanion document) {
    return _documentsDao.updateDocument(document);
    
  }
  
  @override
  Future<void> deleteDocument(int id) {
    return _documentsDao.deleteDocument(id);
  }

  
  @override
  Future<void> createDocumentWithFile({
    required String title,
    String? description,
    required File file,
    MainType? mainType,
    DateTime? expirationDate,
    bool isFavorite = false,
  }) async {
    // 1. Save the file to a secure app directory
    final appDir = await getApplicationDocumentsDirectory();
    final documentsDir = Directory(p.join(appDir.path, 'vault')); // Creates a 'vault' subdirectory
    if (!await documentsDir.exists()) {
      await documentsDir.create(recursive: true);
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final originalExtension = p.extension(file.path);
    final savedFileName = '$timestamp$originalExtension';
    final savedFile = File(p.join(documentsDir.path, savedFileName));
    
    await file.copy(savedFile.path);

    // 2. Create the database entry with the new file path
    final documentCompanion = DocumentsCompanion(
      title: drift.Value(title),
      description: drift.Value(description),
      filePath: drift.Value(savedFile.path), // Use the new path
      mainType: drift.Value(mainType),
      creationDate: drift.Value(DateTime.now()),
      updatedDate: drift.Value(DateTime.now()),
      expirationDate: drift.Value(expirationDate),
      isFavorite: drift.Value(isFavorite),
      isArchived: const drift.Value(false),
    );

    // 3. Insert into the database via the DAO
    await _documentsDao.insertDocument(documentCompanion);
  }
  
}
