// lib/features/documents/presentation/controllers/edit_form_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/models/document_type.dart';
import '../helpers/edit_document_validation_helpers.dart';

/// Controller for edit form field management
final editFormControllerProvider = StateNotifierProvider.autoDispose<EditFormController, EditFormState>(
  (ref) => EditFormController(),
);

class EditFormController extends StateNotifier<EditFormState> {
  EditFormController() : super(const EditFormState.initial());

  // Text controllers for form fields
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  /// Initialize form with document data
  void initializeForm({
    required String title,
    required String description,
    required MainType? documentType,
    required DateTime? expirationDate,
    required bool isFavorite,
  }) {
    titleController.text = title;
    descriptionController.text = description;
    
    state = EditFormState.loaded(
      documentType: documentType,
      expirationDate: expirationDate,
      isFavorite: isFavorite,
      titleError: null,
      descriptionError: null,
    );
  }

  /// Update document type
  void updateDocumentType(MainType? type) {
    state = state.copyWith(documentType: type);
  }

  /// Update expiration date
  void updateExpirationDate(DateTime? date) {
    state = state.copyWith(expirationDate: date);
  }

  /// Update favorite status
  void updateFavoriteStatus(bool isFavorite) {
    state = state.copyWith(isFavorite: isFavorite);
  }

  /// Validate title field
  void validateTitle() {
    final error = EditDocumentValidationHelpers.validateTitle(titleController.text);
    state = state.copyWith(titleError: error);
  }

  /// Validate description field
  void validateDescription() {
    final error = EditDocumentValidationHelpers.validateDescription(descriptionController.text);
    state = state.copyWith(descriptionError: error);
  }

  /// Validate all form fields
  bool validateForm() {
    validateTitle();
    validateDescription();
    
    final formValid = formKey.currentState?.validate() ?? false;
    final hasFieldErrors = state.titleError != null || state.descriptionError != null;
    
    return formValid && !hasFieldErrors;
  }

  /// Clear all form fields
  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    
    state = const EditFormState.loaded(
      documentType: null,
      expirationDate: null,
      isFavorite: false,
      titleError: null,
      descriptionError: null,
    );
  }

  /// Reset form validation errors
  void clearValidationErrors() {
    state = state.copyWith(
      titleError: null,
      descriptionError: null,
    );
  }

  /// Check if form has any content
  bool hasContent() {
    return titleController.text.trim().isNotEmpty ||
           descriptionController.text.trim().isNotEmpty ||
           state.documentType != null ||
           state.expirationDate != null ||
           state.isFavorite;
  }

  /// Get current form data
  FormData getCurrentFormData() {
    return FormData(
      title: titleController.text,
      description: descriptionController.text,
      documentType: state.documentType,
      expirationDate: state.expirationDate,
      isFavorite: state.isFavorite,
    );
  }

  /// Set form focus to title field
  void focusTitle() {
    // This would need to be called from the widget with a FocusNode
  }

  /// Set form focus to description field
  void focusDescription() {
    // This would need to be called from the widget with a FocusNode
  }

  /// Get title character count
  String getTitleCharacterCount() {
    return EditDocumentValidationHelpers.getCharacterCount(titleController.text, 255);
  }

  /// Get description character count
  String getDescriptionCharacterCount() {
    return EditDocumentValidationHelpers.getCharacterCount(descriptionController.text, 1000);
  }

  /// Check if title is approaching character limit
  bool isTitleApproachingLimit() {
    return EditDocumentValidationHelpers.isApproachingLimit(titleController.text, 255);
  }

  /// Check if description is approaching character limit
  bool isDescriptionApproachingLimit() {
    return EditDocumentValidationHelpers.isApproachingLimit(descriptionController.text, 1000);
  }

  /// Check if title exceeds character limit
  bool titleExceedsLimit() {
    return EditDocumentValidationHelpers.exceedsLimit(titleController.text, 255);
  }

  /// Check if description exceeds character limit
  bool descriptionExceedsLimit() {
    return EditDocumentValidationHelpers.exceedsLimit(descriptionController.text, 1000);
  }
}

/// State class for edit form
@immutable
sealed class EditFormState {
  const EditFormState();

  const factory EditFormState.initial() = _Initial;
  const factory EditFormState.loaded({
    required MainType? documentType,
    required DateTime? expirationDate,
    required bool isFavorite,
    required String? titleError,
    required String? descriptionError,
  }) = _Loaded;
}

class _Initial extends EditFormState {
  const _Initial();
}

class _Loaded extends EditFormState {
  final MainType? documentType;
  final DateTime? expirationDate;
  final bool isFavorite;
  final String? titleError;
  final String? descriptionError;

  const _Loaded({
    required this.documentType,
    required this.expirationDate,
    required this.isFavorite,
    required this.titleError,
    required this.descriptionError,
  });
}

/// Extension for EditFormState
extension EditFormStateExtension on EditFormState {
  bool get isInitial => this is _Initial;
  bool get isLoaded => this is _Loaded;

  MainType? get documentType => switch (this) {
    _Loaded(documentType: final type) => type,
    _ => null,
  };

  DateTime? get expirationDate => switch (this) {
    _Loaded(expirationDate: final date) => date,
    _ => null,
  };

  bool get isFavorite => switch (this) {
    _Loaded(isFavorite: final favorite) => favorite,
    _ => false,
  };

  String? get titleError => switch (this) {
    _Loaded(titleError: final error) => error,
    _ => null,
  };

  String? get descriptionError => switch (this) {
    _Loaded(descriptionError: final error) => error,
    _ => null,
  };

  bool get hasErrors => titleError != null || descriptionError != null;

  EditFormState copyWith({
    MainType? documentType,
    DateTime? expirationDate,
    bool? isFavorite,
    String? titleError,
    String? descriptionError,
  }) {
    return switch (this) {
      _Loaded(
        documentType: final currentType,
        expirationDate: final currentDate,
        isFavorite: final currentFavorite,
        titleError: final currentTitleError,
        descriptionError: final currentDescError,
      ) => EditFormState.loaded(
        documentType: documentType ?? currentType,
        expirationDate: expirationDate ?? currentDate,
        isFavorite: isFavorite ?? currentFavorite,
        titleError: titleError ?? currentTitleError,
        descriptionError: descriptionError ?? currentDescError,
      ),
      _ => this,
    };
  }
}

/// Data class for form data
class FormData {
  final String title;
  final String description;
  final MainType? documentType;
  final DateTime? expirationDate;
  final bool isFavorite;

  const FormData({
    required this.title,
    required this.description,
    required this.documentType,
    required this.expirationDate,
    required this.isFavorite,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormData &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          documentType == other.documentType &&
          expirationDate == other.expirationDate &&
          isFavorite == other.isFavorite;

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
      documentType.hashCode ^
      expirationDate.hashCode ^
      isFavorite.hashCode;

  @override
  String toString() {
    return 'FormData{title: $title, description: $description, documentType: $documentType, expirationDate: $expirationDate, isFavorite: $isFavorite}';
  }
}
