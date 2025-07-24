// lib/features/documents/presentation/controllers/document_form_controller.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/models/document_type.dart';
import '../../data/repositories/document_repository.dart';
import '../providers/document_providers.dart';

// Provider for the document form controller
final documentFormControllerProvider = StateNotifierProvider.autoDispose<DocumentFormController, AsyncValue<void>>(
  (ref) => DocumentFormController(ref.read(documentRepositoryProvider)),
);

class DocumentFormController extends StateNotifier<AsyncValue<void>> {
  final DocumentRepository _repository;

  DocumentFormController(this._repository) : super(const AsyncValue.data(null));

  /// Save document with file
  Future<void> saveDocumentWithFile({
    required String title,
    required File file,
    MainType? mainType,
    String? description,
    DateTime? expirationDate,
    bool isFavorite = false,
  }) async {
    debugPrint('💾 [FormController] Starting save process for: $title');
    
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      debugPrint('💾 [FormController] Calling repository.createDocumentWithFile()');
      
      await _repository.createDocumentWithFile(
        title: title.trim(),
        file: file,
        mainType: mainType,
        description: description?.trim().isEmpty == true ? null : description?.trim(),
        expirationDate: expirationDate,
        isFavorite: isFavorite,
      );
      
      debugPrint('✅ [FormController] Document saved successfully');
    });
  }

  /// Reset the form state
  void reset() {
    state = const AsyncValue.data(null);
  }
}
