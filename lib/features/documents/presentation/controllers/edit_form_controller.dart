// lib/features/documents/presentation/controllers/edit_form_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/models/document_type.dart';
import '../helpers/edit_document_mapping_helpers.dart';
import 'edit_form_state.dart'; // <-- Import the new state file

// This provider now creates a unique controller for each document.
final editFormControllerProvider = StateNotifierProvider.autoDispose.family<EditFormController, EditFormState, Document>(
  (ref, document) => EditFormController(document),
);

class EditFormController extends StateNotifier<EditFormState> {
  final Document _originalDocument;

  EditFormController(this._originalDocument) : super(const EditFormState.initial()) {
    // Initialize the form immediately upon creation
    initializeForm();
  }

  // Text controllers are managed here to be accessible by the UI
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  /// Initialize form with the original document data
  void initializeForm() {
    final initialFormData = EditDocumentMappingHelpers.documentToFormData(_originalDocument);
    titleController.text = initialFormData.title;
    descriptionController.text = initialFormData.description;
    
    state = EditFormState.loaded(
      formData: initialFormData,
      validationErrors: {},
    );
  }

  // --- FIX: All update methods now use public APIs and pattern matching correctly ---

  void updateTitle(String title) {
    // Use the public extension getter to safely access formData
    final currentFormData = state.formData;
    if (currentFormData != null) {
      // Use the public copyWith on the data class
      final updatedFormData = currentFormData.copyWith(title: title);
      // Create a new state with the updated data
      state = EditFormState.loaded(
        formData: updatedFormData,
        validationErrors: state.validationErrors, // Preserve existing errors
      );
    }
  }

  void updateDescription(String description) {
    final currentFormData = state.formData;
    if (currentFormData != null) {
      final updatedFormData = currentFormData.copyWith(description: description);
      state = EditFormState.loaded(
        formData: updatedFormData,
        validationErrors: state.validationErrors,
      );
    }
  }

  void updateDocumentType(MainType? type) {
    final currentFormData = state.formData;
    if (currentFormData != null) {
      final updatedFormData = currentFormData.copyWith(mainType: type);
      state = EditFormState.loaded(
        formData: updatedFormData,
        validationErrors: state.validationErrors,
      );
    }
  }

  void updateExpirationDate(DateTime? date) {
    final currentFormData = state.formData;
    if (currentFormData != null) {
      final updatedFormData = currentFormData.copyWith(expirationDate: date);
      state = EditFormState.loaded(
        formData: updatedFormData,
        validationErrors: state.validationErrors,
      );
    }
  }

  void updateFavoriteStatus(bool isFavorite) {
    final currentFormData = state.formData;
    if (currentFormData != null) {
      final updatedFormData = currentFormData.copyWith(isFavorite: isFavorite);
      state = EditFormState.loaded(
        formData: updatedFormData,
        validationErrors: state.validationErrors,
      );
    }
  }
}
