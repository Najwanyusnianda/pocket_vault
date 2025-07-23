// lib/features/documents/presentation/controllers/edit_form_state.dart

import 'package:flutter/material.dart';
import '../helpers/edit_document_mapping_helpers.dart';

@immutable
sealed class EditFormState {
  const EditFormState();

  const factory EditFormState.initial() = _Initial;
  const factory EditFormState.loaded({
    required EditDocumentFormData formData,
    required Map<String, String> validationErrors,
  }) = _Loaded;
}

class _Initial extends EditFormState {
  const _Initial();
}

class _Loaded extends EditFormState {
  final EditDocumentFormData formData;
  final Map<String, String> validationErrors;

  const _Loaded({
    required this.formData,
    required this.validationErrors,
  });

  _Loaded copyWith({
    EditDocumentFormData? formData,
    Map<String, String>? validationErrors,
  }) {
    return _Loaded(
      formData: formData ?? this.formData,
      validationErrors: validationErrors ?? this.validationErrors,
    );
  }
}

// Helper extension to make accessing state properties easier and safer
extension EditFormStateExtension on EditFormState {
  bool get isLoaded => this is _Loaded;

  EditDocumentFormData? get formData {
    if (this is _Loaded) {
      return (this as _Loaded).formData;
    }
    return null;
  }

  Map<String, String> get validationErrors {
    if (this is _Loaded) {
      return (this as _Loaded).validationErrors;
    }
    return {};
  }
}
