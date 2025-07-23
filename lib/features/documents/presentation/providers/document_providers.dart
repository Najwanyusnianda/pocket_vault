// lib/features/documents/presentation/providers/document_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/documents_dao.dart';
import '../../../../core/database/models/document_type.dart';
import '../../data/repositories/document_repository.dart';
import '../../data/repositories/document_repository_impl.dart';
import '../../data/models/document_filter.dart';

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

// 4. Search Query Provider
final documentSearchQueryProvider = StateProvider<String>((ref) => '');

// 5. Filter State Provider - Using simpler StateProvider for now
final documentFilterStateProvider = StateProvider<DocumentFilter>((ref) => const DocumentFilter());

// 6. Combined filtered document list provider
@riverpod
Stream<List<Document>> filteredDocumentList(Ref ref) {
  final repository = ref.watch(documentRepositoryProvider);
  final searchQuery = ref.watch(documentSearchQueryProvider);
  final filterState = ref.watch(documentFilterStateProvider);

  return repository.watchAllDocuments().map((documents) {
    var filtered = documents;

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((doc) =>
        doc.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
        (doc.description?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false) ||
        (doc.tags?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
      ).toList();
    }

    // Apply filters
    if (filterState.showFavoritesOnly) {
      filtered = filtered.where((doc) => doc.isFavorite).toList();
    }

    if (filterState.showArchivedOnly) {
      filtered = filtered.where((doc) => doc.isArchived).toList();
    }

    if (filterState.mainTypeFilter != null) {
      filtered = filtered.where((doc) => doc.mainType == filterState.mainTypeFilter).toList();
    }

    // Apply sorting
    switch (filterState.sortBy) {
      case DocumentSortBy.dateDesc:
        filtered.sort((a, b) => b.creationDate.compareTo(a.creationDate));
        break;
      case DocumentSortBy.dateAsc:
        filtered.sort((a, b) => a.creationDate.compareTo(b.creationDate));
        break;
      case DocumentSortBy.nameAsc:
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
      case DocumentSortBy.nameDesc:
        filtered.sort((a, b) => b.title.compareTo(a.title));
        break;
    }

    return filtered;
  });
}

// 7. THE UI PROVIDER: A stream provider the UI will listen to (keeping for backward compatibility)
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
