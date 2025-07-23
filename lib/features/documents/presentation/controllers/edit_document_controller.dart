// lib/features/documents/presentation/controllers/edit_docum  /// Update favorite status
  void updateFavorite(bool isFavorite) {
    _formData = _formData.copyWith(isFavorite: isFavorite);
    _updateStateWithValidation();
  }

  /// Reset form to original values
  void resetForm() {
    _formData = EditDocumentMappingHelpers.documentToFormData(_originalDocument);
    state = EditDocumentState.loaded(_formData);
  }ontroller.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../providers/document_providers.dart';
import '../helpers/edit_document_mapping_helpers.dart';
import '../helpers/edit_document_validation_helpers.dart';

/// Controller for edit document screen business logic
final editDocumentControllerProvider = StateNotifierProvider.family<EditDocumentController, EditDocumentState, Document>(
  (ref, document) => EditDocumentController(ref, document),
);

class EditDocumentController extends StateNotifier<EditDocumentState> {
  final Ref _ref;
  final Document _originalDocument;
  late EditDocumentFormData _formData;

  EditDocumentController(this._ref, this._originalDocument) 
      : super(const EditDocumentState.initial()) {
    _initializeFormData();
  }

  /// Initialize form data from the original document
  void _initializeFormData() {
    _formData = EditDocumentMappingHelpers.documentToFormData(_originalDocument);
    state = EditDocumentState.loaded(_formData);
  }

  /// Get current form data
  EditDocumentFormData get formData => _formData;

  /// Get original document
  Document get originalDocument => _originalDocument;

  /// Update title
  void updateTitle(String title) {
    _formData = _formData.copyWith(title: title);
    _updateStateWithValidation();
  }

  /// Update description
  void updateDescription(String description) {
    _formData = _formData.copyWith(description: description);
    _updateStateWithValidation();
  }

  /// Update document type
  void updateDocumentType(MainType? type) {
    _formData = _formData.copyWith(mainType: type);
    _updateStateWithValidation();
  }

  /// Update expiration date
  void updateExpirationDate(DateTime? date) {
    _formData = _formData.copyWith(expirationDate: date);
    _updateStateWithValidation();
  }

  /// Update favorite status
  void updateFavoriteStatus(bool isFavorite) {
    _formData = _formData.copyWith(isFavorite: isFavorite);
    _updateStateWithValidation();
  }

  /// Check if form has unsaved changes
  bool hasUnsavedChanges() {
    return EditDocumentMappingHelpers.hasFormDataChanged(_originalDocument, _formData);
  }

  /// Validate current form data
  EditDocumentValidationResult validateForm() {
    return EditDocumentValidationHelpers.validateForm(
      title: _formData.title,
      description: _formData.description,
      documentType: _formData.mainType,
      expirationDate: _formData.expirationDate,
    );
  }

  /// Update state with current validation
  void _updateStateWithValidation() {
    final validation = validateForm();
    final hasChanges = hasUnsavedChanges();
    
    state = EditDocumentState.loaded(
      _formData,
      validation: validation,
      hasUnsavedChanges: hasChanges,
    );
  }

  /// Save document changes
  Future<void> saveDocument(BuildContext context) async {
    // Validate form first
    final validation = validateForm();
    if (!validation.isValid) {
      state = EditDocumentState.validationError(validation);
      return;
    }

    // Check if there are changes to save
    if (!hasUnsavedChanges()) {
      _showInfoMessage(context, 'No changes to save');
      return;
    }

    state = const EditDocumentState.saving();

    try {
      // Convert form data to companion
      final companion = EditDocumentMappingHelpers.formDataToCompanion(_formData);
      
      // Update document using provider
      await _ref.read(documentUpdateProvider.notifier).updateDocument(companion);
      
      state = const EditDocumentState.saved();
      
      if (context.mounted) {
        context.pop();
        _showSuccessMessage(context, 'Document updated successfully');
      }
    } catch (e) {
      state = EditDocumentState.error('Failed to update document: $e');
      if (context.mounted) {
        _showErrorMessage(context, 'Failed to update document: $e');
      }
    }
  }

  /// Reset form to original values
  void resetForm() {
    _formData = EditDocumentMappingHelpers.documentToFormData(_originalDocument);
    state = EditDocumentState.loaded(_formData);
  }

  /// Handle navigation back with unsaved changes check
  Future<bool> handleBackNavigation(BuildContext context) async {
    if (!hasUnsavedChanges()) {
      return true; // Allow navigation
    }

    return await _showUnsavedChangesDialog(context);
  }

  /// Show unsaved changes confirmation dialog
  Future<bool> _showUnsavedChangesDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unsaved Changes'),
        content: const Text(
          'You have unsaved changes. Are you sure you want to leave without saving?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Leave'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              saveDocument(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ) ?? false;
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

  /// Show info message
  void _showInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
    );
  }

  /// Get changes summary for confirmation
  String getChangesSummary() {
    return EditDocumentMappingHelpers.getChangesSummary(_originalDocument, _formData);
  }
}

/// State class for edit document operations
@immutable
sealed class EditDocumentState {
  const EditDocumentState();

  const factory EditDocumentState.initial() = _Initial;
  const factory EditDocumentState.loaded(
    EditDocumentFormData formData, {
    EditDocumentValidationResult? validation,
    bool hasUnsavedChanges,
  }) = _Loaded;
  const factory EditDocumentState.saving() = _Saving;
  const factory EditDocumentState.saved() = _Saved;
  const factory EditDocumentState.validationError(EditDocumentValidationResult validation) = _ValidationError;
  const factory EditDocumentState.error(String message) = _Error;
}

class _Initial extends EditDocumentState {
  const _Initial();
}

class _Loaded extends EditDocumentState {
  final EditDocumentFormData formData;
  final EditDocumentValidationResult? validation;
  final bool hasUnsavedChanges;

  const _Loaded(this.formData, {this.validation, this.hasUnsavedChanges = false});
}

class _Saving extends EditDocumentState {
  const _Saving();
}

class _Saved extends EditDocumentState {
  const _Saved();
}

class _ValidationError extends EditDocumentState {
  final EditDocumentValidationResult validation;
  const _ValidationError(this.validation);
}

class _Error extends EditDocumentState {
  final String message;
  const _Error(this.message);
}

/// Extension for state checking
extension EditDocumentStateExtension on EditDocumentState {
  bool get isInitial => this is _Initial;
  bool get isLoaded => this is _Loaded;
  bool get isSaving => this is _Saving;
  bool get isSaved => this is _Saved;
  bool get isValidationError => this is _ValidationError;
  bool get isError => this is _Error;
  
  EditDocumentFormData? get formData => switch (this) {
    _Loaded(formData: final data) => data,
    _ => null,
  };
  
  EditDocumentValidationResult? get validation => switch (this) {
    _Loaded(validation: final validation) => validation,
    _ValidationError(validation: final validation) => validation,
    _ => null,
  };
  
  bool get hasUnsavedChanges => switch (this) {
    _Loaded(hasUnsavedChanges: final hasChanges) => hasChanges,
    _ => false,
  };
  
  String? get errorMessage => switch (this) {
    _Error(message: final msg) => msg,
    _ => null,
  };
}
