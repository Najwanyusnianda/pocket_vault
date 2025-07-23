// lib/features/documents/presentation/controllers/document_detail_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../providers/document_providers.dart';

/// Controller for document detail screen business logic
final documentDetailControllerProvider = StateNotifierProvider.family<DocumentDetailController, DocumentDetailState, int>(
  (ref, documentId) => DocumentDetailController(ref, documentId),
);

class DocumentDetailController extends StateNotifier<DocumentDetailState> {
  final Ref _ref;
  final int _documentId;

  DocumentDetailController(this._ref, this._documentId) 
      : super(const DocumentDetailState.initial());

  /// Navigate to edit screen
  Future<void> navigateToEdit(BuildContext context, Document document) async {
    try {
      context.push('/document/$_documentId/edit', extra: document);
    } catch (e) {
      state = DocumentDetailState.error('Failed to navigate to edit: $e');
    }
  }

  /// Delete document with confirmation
  Future<void> deleteDocument(BuildContext context) async {
    final confirmed = await _showDeleteConfirmation(context);
    if (!confirmed) return;

    state = const DocumentDetailState.deleting();

    try {
      final repository = _ref.read(documentRepositoryProvider);
      await repository.deleteDocument(_documentId);
      
      state = const DocumentDetailState.deleted();
      
      if (context.mounted) {
        context.pop(); // Go back to document list
        _showSuccessMessage(context, 'Document deleted successfully');
      }
    } catch (e) {
      state = DocumentDetailState.error('Failed to delete document: $e');
      if (context.mounted) {
        _showErrorMessage(context, 'Error deleting document: $e');
      }
    }
  }

  /// Show delete confirmation dialog
  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    final document = await _getDocument();
    if (document == null) return false;

    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Document'),
        content: Text(
          'Are you sure you want to delete "${document.title}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    ) ?? false;
  }

  /// Get current document
  Future<Document?> _getDocument() async {
    try {
      final repository = _ref.read(documentRepositoryProvider);
      return await repository.getDocumentById(_documentId);
    } catch (e) {
      return null;
    }
  }

  /// Show success message
  void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  /// Show error message
  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  /// Reset state
  void resetState() {
    state = const DocumentDetailState.initial();
  }
}

/// State class for document detail operations
@immutable
sealed class DocumentDetailState {
  const DocumentDetailState();

  const factory DocumentDetailState.initial() = _Initial;
  const factory DocumentDetailState.deleting() = _Deleting;
  const factory DocumentDetailState.deleted() = _Deleted;
  const factory DocumentDetailState.error(String message) = _Error;
}

class _Initial extends DocumentDetailState {
  const _Initial();
}

class _Deleting extends DocumentDetailState {
  const _Deleting();
}

class _Deleted extends DocumentDetailState {
  const _Deleted();
}

class _Error extends DocumentDetailState {
  final String message;
  const _Error(this.message);
}

/// Extension for state checking
extension DocumentDetailStateExtension on DocumentDetailState {
  bool get isInitial => this is _Initial;
  bool get isDeleting => this is _Deleting;
  bool get isDeleted => this is _Deleted;
  bool get isError => this is _Error;
  
  String? get errorMessage => this is _Error ? (this as _Error).message : null;
}
