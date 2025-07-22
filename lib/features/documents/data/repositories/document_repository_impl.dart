import '../../../../core/database/daos/documents_dao.dart';
import '../../../../core/database/app_database.dart';
import 'document_repository.dart';

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
}
