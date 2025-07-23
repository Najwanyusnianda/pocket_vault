// lib/features/documents/presentation/helpers/edit_document_validation_helpers.dart

import 'package:flutter/material.dart';
import '../../../../core/database/models/document_type.dart';

/// Helper class for edit document form validation
class EditDocumentValidationHelpers {
  EditDocumentValidationHelpers._();

  /// Validates document title
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a title';
    }
    
    if (value.trim().length < 2) {
      return 'Title must be at least 2 characters';
    }
    
    if (value.trim().length > 255) {
      return 'Title must be less than 255 characters';
    }
    
    // Check for invalid characters
    final invalidChars = RegExp(r'[<>:"/\\|?*]');
    if (invalidChars.hasMatch(value)) {
      return 'Title contains invalid characters';
    }
    
    return null;
  }

  /// Validates document description
  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Description is optional
    }
    
    if (value.trim().length > 1000) {
      return 'Description must be less than 1000 characters';
    }
    
    return null;
  }

  /// Validates document type selection
  static String? validateDocumentType(MainType? type) {
    // Document type is optional, so no validation needed
    return null;
  }

  /// Validates expiration date
  static String? validateExpirationDate(DateTime? expirationDate) {
    if (expirationDate == null) {
      return null; // Expiration date is optional
    }
    
    // Check if expiration date is in the past
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final expiration = DateTime(expirationDate.year, expirationDate.month, expirationDate.day);
    
    if (expiration.isBefore(today)) {
      return 'Expiration date cannot be in the past';
    }
    
    // Check if expiration date is too far in the future (100 years)
    final maxDate = DateTime.now().add(const Duration(days: 365 * 100));
    if (expirationDate.isAfter(maxDate)) {
      return 'Expiration date is too far in the future';
    }
    
    return null;
  }

  /// Validates the entire form
  static EditDocumentValidationResult validateForm({
    required String? title,
    required String? description,
    required MainType? documentType,
    required DateTime? expirationDate,
  }) {
    final errors = <String, String>{};
    
    final titleError = validateTitle(title);
    if (titleError != null) {
      errors['title'] = titleError;
    }
    
    final descriptionError = validateDescription(description);
    if (descriptionError != null) {
      errors['description'] = descriptionError;
    }
    
    final typeError = validateDocumentType(documentType);
    if (typeError != null) {
      errors['type'] = typeError;
    }
    
    final expirationError = validateExpirationDate(expirationDate);
    if (expirationError != null) {
      errors['expiration'] = expirationError;
    }
    
    return EditDocumentValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }

  /// Gets character count for display
  static String getCharacterCount(String? text, int maxLength) {
    final currentLength = text?.length ?? 0;
    return '$currentLength/$maxLength';
  }

  /// Checks if character count is approaching limit
  static bool isApproachingLimit(String? text, int maxLength) {
    final currentLength = text?.length ?? 0;
    return currentLength > (maxLength * 0.8); // 80% of max length
  }

  /// Checks if character count exceeds limit
  static bool exceedsLimit(String? text, int maxLength) {
    final currentLength = text?.length ?? 0;
    return currentLength > maxLength;
  }

  /// Gets validation color based on character count
  static Color? getValidationColor(BuildContext context, String? text, int maxLength) {
    final currentLength = text?.length ?? 0;
    final colorScheme = Theme.of(context).colorScheme;
    
    if (exceedsLimit(text, maxLength)) {
      return colorScheme.error;
    } else if (isApproachingLimit(text, maxLength)) {
      return Colors.orange;
    }
    
    return null;
  }

  /// Formats validation message for display
  static String formatValidationMessage(String message) {
    return message[0].toUpperCase() + message.substring(1);
  }

  /// Checks if form has unsaved changes
  static bool hasUnsavedChanges({
    required String originalTitle,
    required String? originalDescription,
    required MainType? originalType,
    required DateTime? originalExpirationDate,
    required bool originalIsFavorite,
    required String currentTitle,
    required String? currentDescription,
    required MainType? currentType,
    required DateTime? currentExpirationDate,
    required bool currentIsFavorite,
  }) {
    return originalTitle.trim() != currentTitle.trim() ||
           (originalDescription?.trim() ?? '') != (currentDescription?.trim() ?? '') ||
           originalType != currentType ||
           originalExpirationDate != currentExpirationDate ||
           originalIsFavorite != currentIsFavorite;
  }

  /// Gets field validation status
  static FieldValidationStatus getFieldValidationStatus(String? error) {
    if (error == null) {
      return FieldValidationStatus.valid;
    }
    return FieldValidationStatus.invalid;
  }
}

/// Result of form validation
class EditDocumentValidationResult {
  final bool isValid;
  final Map<String, String> errors;

  const EditDocumentValidationResult({
    required this.isValid,
    required this.errors,
  });

  /// Gets error for a specific field
  String? getFieldError(String fieldName) {
    return errors[fieldName];
  }

  /// Checks if a specific field has an error
  bool hasFieldError(String fieldName) {
    return errors.containsKey(fieldName);
  }

  /// Gets all error messages as a list
  List<String> getAllErrorMessages() {
    return errors.values.toList();
  }

  /// Gets formatted error message for display
  String getFormattedErrorMessage() {
    if (errors.isEmpty) return '';
    
    if (errors.length == 1) {
      return errors.values.first;
    }
    
    return 'Please fix the following errors:\n${errors.values.map((e) => '• $e').join('\n')}';
  }
}

/// Enum for field validation status
enum FieldValidationStatus {
  valid,
  invalid,
  pending,
}

/// Extension for field validation status
extension FieldValidationStatusExtension on FieldValidationStatus {
  bool get isValid => this == FieldValidationStatus.valid;
  bool get isInvalid => this == FieldValidationStatus.invalid;
  bool get isPending => this == FieldValidationStatus.pending;
}
