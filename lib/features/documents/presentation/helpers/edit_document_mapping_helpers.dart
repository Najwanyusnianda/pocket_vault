// lib/features/documents/presentation/helpers/edit_document_mapping_helpers.dart

import 'package:drift/drift.dart' as drift;
import '../../../../core/database/app_database.dart';
import '../../../../core/database/models/document_type.dart';
import 'dart:convert';
import 'document_type_helpers.dart'; 

/// Helper class for mapping between document entities and form data
class EditDocumentMappingHelpers {
  EditDocumentMappingHelpers._();

  /// Maps a Document entity to form data
  static EditDocumentFormData documentToFormData(Document document) {
    // Parse custom fields from JSON string
    Map<String, dynamic> customFields = {};
    
    try {
      // Use the new database field after build_runner regeneration
      final customFieldsJson = document.customFields;
      if (customFieldsJson != null && customFieldsJson.isNotEmpty) {
        customFields = Map<String, dynamic>.from(
          jsonDecode(customFieldsJson) as Map
        );
      }
    } catch (e) {
      customFields = {};
    }

    return EditDocumentFormData(
      id: document.id,
      title: document.title,
      description: document.description ?? '',
      mainType: document.mainType,
      subType: document.subType,
      tags: document.tags ?? '',
      customFields: customFields,
      expirationDate: document.expirationDate,
      isFavorite: document.isFavorite,
      filePath: document.filePath,
      creationDate: document.creationDate,
      updatedDate: document.updatedDate,
      isArchived: document.isArchived,
    );
  }

  /// Maps form data to DocumentsCompanion for database update
  static DocumentsCompanion formDataToCompanion(EditDocumentFormData formData) {
    return DocumentsCompanion(
      id: drift.Value(formData.id),
      title: drift.Value(formData.title.trim()),
      description: drift.Value(
        formData.description.trim().isEmpty ? null : formData.description.trim(),
      ),
      mainType: drift.Value(formData.mainType),
      expirationDate: drift.Value(formData.expirationDate),
      isFavorite: drift.Value(formData.isFavorite),
      updatedDate: drift.Value(DateTime.now()),
      // Keep existing values for these fields
      filePath: drift.Value(formData.filePath),
      creationDate: drift.Value(formData.creationDate),
      isArchived: drift.Value(formData.isArchived),
    );
  }

  /// Creates an updated form data with new values
  static EditDocumentFormData updateFormData(
    EditDocumentFormData original, {
    String? title,
    String? description,
    MainType? mainType,
    SubType? subType,
    String? tags,
    Map<String, dynamic>? customFields,
    DateTime? expirationDate,
    bool? isFavorite,
  }) {
    return EditDocumentFormData(
      id: original.id,
      title: title ?? original.title,
      description: description ?? original.description,
      mainType: mainType ?? original.mainType,
      subType: subType ?? original.subType,
      tags: tags ?? original.tags,
      customFields: customFields ?? original.customFields,
      expirationDate: expirationDate ?? original.expirationDate,
      isFavorite: isFavorite ?? original.isFavorite,
      filePath: original.filePath,
      creationDate: original.creationDate,
      updatedDate: original.updatedDate,
      isArchived: original.isArchived,
    );
  }

  /// Checks if form data has changed from the original document
  static bool hasFormDataChanged(Document original, EditDocumentFormData current) {
    return original.title.trim() != current.title.trim() ||
           (original.description?.trim() ?? '') != current.description.trim() ||
           original.mainType != current.mainType ||
           original.expirationDate != current.expirationDate ||
           original.isFavorite != current.isFavorite;
  }

  /// Gets a list of changed fields
  static List<String> getChangedFields(Document original, EditDocumentFormData current) {
    final changedFields = <String>[];

    if (original.title.trim() != current.title.trim()) {
      changedFields.add('title');
    }

    if ((original.description?.trim() ?? '') != current.description.trim()) {
      changedFields.add('description');
    }

    if (original.mainType != current.mainType) {
      changedFields.add('type');
    }

    if (original.expirationDate != current.expirationDate) {
      changedFields.add('expiration_date');
    }

    if (original.isFavorite != current.isFavorite) {
      changedFields.add('favorite');
    }

    return changedFields;
  }

  /// Creates a summary of changes for confirmation
  static String getChangesSummary(Document original, EditDocumentFormData current) {
    final changes = <String>[];

    if (original.title.trim() != current.title.trim()) {
      changes.add('Title: "${original.title}" → "${current.title}"');
    }

    if ((original.description?.trim() ?? '') != current.description.trim()) {
      final originalDesc = original.description?.trim().isEmpty ?? true 
          ? 'None' 
          : '"${original.description!.trim()}"';
      final currentDesc = current.description.trim().isEmpty 
          ? 'None' 
          : '"${current.description.trim()}"';
      changes.add('Description: $originalDesc → $currentDesc');
    }

    if (original.mainType != current.mainType) {
      final originalType = original.mainType?.getName() ?? 'None';
      final currentType = current.mainType?.getName() ?? 'None';
      changes.add('Type: $originalType → $currentType');
    }

    if (original.expirationDate != current.expirationDate) {
      final originalDate = original.expirationDate?.toString().split(' ')[0] ?? 'None';
      final currentDate = current.expirationDate?.toString().split(' ')[0] ?? 'None';
      changes.add('Expiration: $originalDate → $currentDate');
    }

    if (original.isFavorite != current.isFavorite) {
      changes.add('Favorite: ${original.isFavorite ? 'Yes' : 'No'} → ${current.isFavorite ? 'Yes' : 'No'}');
    }

    return changes.isEmpty ? 'No changes detected' : changes.join('\n');
  }

  /// Validates that required fields are not empty after mapping
  static bool isFormDataValid(EditDocumentFormData formData) {
    return formData.title.trim().isNotEmpty;
  }

  /// Creates a copy of form data
  static EditDocumentFormData copyFormData(EditDocumentFormData original) {
    return EditDocumentFormData(
      id: original.id,
      title: original.title,
      description: original.description,
      mainType: original.mainType,
      subType: original.subType,
      tags: original.tags,
      customFields: Map<String, dynamic>.from(original.customFields),
      expirationDate: original.expirationDate,
      isFavorite: original.isFavorite,
      filePath: original.filePath,
      creationDate: original.creationDate,
      updatedDate: original.updatedDate,
      isArchived: original.isArchived,
    );
  }

  /// Resets form data to original document values
  static EditDocumentFormData resetToOriginal(Document document) {
    return documentToFormData(document);
  }
}

/// Data class for edit document form data
class EditDocumentFormData {
  final int id;
  final String title;
  final String description;
  final MainType? mainType;
  final SubType? subType;
  final String tags;
  final Map<String, dynamic> customFields;
  final DateTime? expirationDate;
  final bool isFavorite;
  final String filePath;
  final DateTime creationDate;
  final DateTime updatedDate;
  final bool isArchived;

  const EditDocumentFormData({
    required this.id,
    required this.title,
    required this.description,
    required this.mainType,
    this.subType,
    required this.tags,
    required this.customFields,
    required this.expirationDate,
    required this.isFavorite,
    required this.filePath,
    required this.creationDate,
    required this.updatedDate,
    required this.isArchived,
  });

  /// Creates a copy with updated values
  EditDocumentFormData copyWith({
    int? id,
    String? title,
    String? description,
    MainType? mainType,
    SubType? subType,
    String? tags,
    Map<String, dynamic>? customFields,
    DateTime? expirationDate,
    bool? isFavorite,
    String? filePath,
    DateTime? creationDate,
    DateTime? updatedDate,
    bool? isArchived,
  }) {
    return EditDocumentFormData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      mainType: mainType ?? this.mainType,
      subType: subType ?? this.subType,
      tags: tags ?? this.tags,
      customFields: customFields ?? this.customFields,
      expirationDate: expirationDate ?? this.expirationDate,
      isFavorite: isFavorite ?? this.isFavorite,
      filePath: filePath ?? this.filePath,
      creationDate: creationDate ?? this.creationDate,
      updatedDate: updatedDate ?? this.updatedDate,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditDocumentFormData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          mainType == other.mainType &&
          subType == other.subType &&
          tags == other.tags &&
          customFields.toString() == other.customFields.toString() &&
          expirationDate == other.expirationDate &&
          isFavorite == other.isFavorite &&
          filePath == other.filePath &&
          creationDate == other.creationDate &&
          updatedDate == other.updatedDate &&
          isArchived == other.isArchived;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      mainType.hashCode ^
      subType.hashCode ^
      tags.hashCode ^
      customFields.toString().hashCode ^
      expirationDate.hashCode ^
      isFavorite.hashCode ^
      filePath.hashCode ^
      creationDate.hashCode ^
      updatedDate.hashCode ^
      isArchived.hashCode;

  @override
  String toString() {
    return 'EditDocumentFormData{id: $id, title: $title, description: $description, mainType: $mainType, subType: $subType, tags: $tags, expirationDate: $expirationDate, isFavorite: $isFavorite, isArchived: $isArchived}';
  }
}
