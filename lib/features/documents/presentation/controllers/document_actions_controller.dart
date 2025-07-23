// lib/features/documents/presentation/controllers/document_actions_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  /// Share document (placeholder for future implementation)
  Future<void> shareDocument() async {
    state = const DocumentActionsState.loading();

    try {
      // TODO: Implement sharing functionality
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      state = const DocumentActionsState.success('Sharing functionality coming soon');
    } catch (e) {
      state = DocumentActionsState.error('Failed to share document: $e');
    }
  }

  /// Export document (placeholder for future implementation)
  Future<void> exportDocument() async {
    state = const DocumentActionsState.loading();

    try {
      // TODO: Implement export functionality
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      state = const DocumentActionsState.success('Export functionality coming soon');
    } catch (e) {
      state = DocumentActionsState.error('Failed to export document: $e');
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
