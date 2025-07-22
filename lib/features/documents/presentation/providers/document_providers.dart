// lib/features/documents/presentation/providers/document_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/documents_dao.dart';
import '../../data/repositories/document_repository.dart';
import '../../data/repositories/document_repository_impl.dart';

part 'document_providers.g.dart'; // Run build_runner again after creating this

// 1. Provider for the Database instance
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

// 2. Provider for the DAO
@Riverpod(keepAlive: true)
DocumentsDao documentsDao(Ref ref) {
  return DocumentsDao(ref.watch(appDatabaseProvider));
}

// 3. Provider for the Repository
@riverpod
DocumentRepository documentRepository(Ref ref) {
  return DocumentRepositoryImpl(ref.watch(documentsDaoProvider));
}

// 4. THE UI PROVIDER: A stream provider the UI will listen to
@riverpod
Stream<List<Document>> documentListStream(Ref ref) {
  final repository = ref.watch(documentRepositoryProvider);
  return repository.watchAllDocuments();
}
// 5. Provider for adding a document
@riverpod
class DocumentForm extends _$DocumentForm {
  @override
  FutureOr<void> build() {
    // No initial state needed
  }

  Future<void> addDocument(DocumentsCompanion document) async {
    // Set state to loading
    state = const AsyncValue.loading();
    
    // Get the repository
    final repository = ref.read(documentRepositoryProvider);

    // Use AsyncValue.guard to handle success/error states automatically
    state = await AsyncValue.guard(() {
      return repository.addDocument(document);
    });
  }
}
