// lib/features/documents/presentation/controllers/document_actions_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../providers/document_providers.dart';

/// Controller for document action operations (favorite, archive, etc.)
final documentActionsControllerProvider = StateNotifierProvider.family<DocumentActionsController, DocumentActionsState, int>(
  (ref, documentId) => DocumentActionsController(ref, documentId),
);

class DocumentActionsController extends StateNotifier<DocumentActionsState> {
  final Ref _ref;
  final int _documentId;

  DocumentActionsController(this._ref, this._documentId) 
      : super(const DocumentActionsState.initial());

  /// Toggle favorite status
  Future<void> toggleFavorite() async {
    state = const DocumentActionsState.loading();

    try {
      final repository = _ref.read(documentRepositoryProvider);
      final document = await repository.getDocumentById(_documentId);
      
      final updatedDocument = document.copyWith(
        isFavorite: !document.isFavorite,
        updatedDate: DateTime.now(),
      );

      await repository.updateDocument(updatedDocument.toCompanion(true));
      
      state = DocumentActionsState.success(
        document.isFavorite ? 'Removed from favorites' : 'Added to favorites',
      );
    } catch (e) {
      state = DocumentActionsState.error('Failed to update favorite status: $e');
    }
  }

  /// Toggle archive status
  Future<void> toggleArchive() async {
    state = const DocumentActionsState.loading();

    try {
      final repository = _ref.read(documentRepositoryProvider);
      final document = await repository.getDocumentById(_documentId);
      
      final updatedDocument = document.copyWith(
        isArchived: !document.isArchived,
        updatedDate: DateTime.now(),
      );

      await repository.updateDocument(updatedDocument.toCompanion(true));
      
      state = DocumentActionsState.success(
        document.isArchived ? 'Unarchived document' : 'Archived document',
      );
    } catch (e) {
      state = DocumentActionsState.error('Failed to update archive status: $e');
    }
  }

  /// Share document functionality
  Future<void> shareDocument() async {
    state = const DocumentActionsState.loading();

    try {
      final repository = _ref.read(documentRepositoryProvider);
      final document = await repository.getDocumentById(_documentId);
      
      // TODO: Implement actual sharing using share_plus package
      // For now, simulate sharing
      await Future.delayed(const Duration(milliseconds: 500));
      
      state = DocumentActionsState.success('Document "${document.title}" shared successfully');
    } catch (e) {
      state = DocumentActionsState.error('Failed to share document: $e');
    }
  }

  /// Edit document navigation (helper method)
  Future<void> editDocument() async {
    // This doesn't need loading state as it's just navigation
    try {
      state = const DocumentActionsState.success('Navigating to edit...');
    } catch (e) {
      state = DocumentActionsState.error('Failed to navigate to edit: $e');
    }
  }

  /// Delete document with confirmation
  Future<void> deleteDocument() async {
    state = const DocumentActionsState.loading();

    try {
      final repository = _ref.read(documentRepositoryProvider);
      
      // Use the DAO method that handles bundle cleanup
      await repository.deleteDocument(_documentId);
      
      state = const DocumentActionsState.success('Document deleted successfully');
    } catch (e) {
      state = DocumentActionsState.error('Failed to delete document: $e');
    }
  }

  /// Add document to bundle
  Future<void> addToBundle(int bundleId) async {
    state = const DocumentActionsState.loading();

    try {
      // Access the database directly for bundle operations
      final database = _ref.read(appDatabaseProvider);
      
      // Check if document is already in the bundle
      final existingLink = await (database.select(database.bundleDocuments)
        ..where((tbl) => tbl.documentId.equals(_documentId))
        ..where((tbl) => tbl.bundleId.equals(bundleId))
      ).getSingleOrNull();

      if (existingLink != null) {
        state = const DocumentActionsState.error('Document is already in this bundle');
        return;
      }

      // Add document to bundle
      await database.into(database.bundleDocuments).insert(
        BundleDocumentsCompanion(
          documentId: Value(_documentId),
          bundleId: Value(bundleId),
          dateAdded: Value(DateTime.now()),
        ),
      );

      // Get bundle name for success message
      final bundle = await (database.select(database.bundles)
        ..where((tbl) => tbl.id.equals(bundleId))
      ).getSingle();

      state = DocumentActionsState.success('Added to bundle "${bundle.name}"');
    } catch (e) {
      state = DocumentActionsState.error('Failed to add to bundle: $e');
    }
  }

  /// Remove document from bundle
  Future<void> removeFromBundle(int bundleId) async {
    state = const DocumentActionsState.loading();

    try {
      final database = _ref.read(appDatabaseProvider);
      
      final deletedRows = await (database.delete(database.bundleDocuments)
        ..where((tbl) => tbl.documentId.equals(_documentId))
        ..where((tbl) => tbl.bundleId.equals(bundleId))
      ).go();

      if (deletedRows > 0) {
        final bundle = await (database.select(database.bundles)
          ..where((tbl) => tbl.id.equals(bundleId))
        ).getSingle();
        
        state = DocumentActionsState.success('Removed from bundle "${bundle.name}"');
      } else {
        state = const DocumentActionsState.error('Document was not in this bundle');
      }
    } catch (e) {
      state = DocumentActionsState.error('Failed to remove from bundle: $e');
    }
  }

  /// Reset state
  void resetState() {
    state = const DocumentActionsState.initial();
  }

  /// Show action result message
  void showMessage(BuildContext context) {
    final currentState = state;
    if (currentState is _Success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(currentState.message),
          backgroundColor: Colors.green,
        ),
      );
    } else if (currentState is _Error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(currentState.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}

/// State class for document actions
@immutable
sealed class DocumentActionsState {
  const DocumentActionsState();

  const factory DocumentActionsState.initial() = _Initial;
  const factory DocumentActionsState.loading() = _Loading;
  const factory DocumentActionsState.success(String message) = _Success;
  const factory DocumentActionsState.error(String message) = _Error;
}

class _Initial extends DocumentActionsState {
  const _Initial();
}

class _Loading extends DocumentActionsState {
  const _Loading();
}

class _Success extends DocumentActionsState {
  final String message;
  const _Success(this.message);
}

class _Error extends DocumentActionsState {
  final String message;
  const _Error(this.message);
}

/// Extension for state checking
extension DocumentActionsStateExtension on DocumentActionsState {
  bool get isInitial => this is _Initial;
  bool get isLoading => this is _Loading;
  bool get isSuccess => this is _Success;
  bool get isError => this is _Error;
  
  String? get message => switch (this) {
    _Success(message: final msg) => msg,
    _Error(message: final msg) => msg,
    _ => null,
  };
}
