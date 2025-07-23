// lib/features/documents/presentation/controllers/add_document_controller.dart

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/file_picker_service.dart';

// This provider will be watched by the UI to react to state changes.
final addDocumentControllerProvider = StateNotifierProvider.autoDispose<AddDocumentController, AsyncValue<FilePickerResult?>>(
  (ref) => AddDocumentController(ref.read(filePickerServiceProvider)),
);

class AddDocumentController extends StateNotifier<AsyncValue<FilePickerResult?>> {
  final FilePickerService _filePickerService;

  AddDocumentController(this._filePickerService) : super(const AsyncData(null));

  Future<void> takePhoto() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      debugPrint('🎯 [Controller] Starting takePhoto()');
      final result = await _filePickerService.pickImageFromCamera();
      if (result.isSuccess) {
        debugPrint('✅ [Controller] Photo picked successfully: ${result.file?.path}');
        return result;
      }
      debugPrint('❌ [Controller] Photo picking failed: ${result.error}');
      throw result.error ?? 'Failed to take photo';
    });
  }

  Future<void> chooseFile() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      debugPrint('🎯 [Controller] Starting chooseFile()');
      final result = await _filePickerService.pickFile();
      if (result.isSuccess) {
        debugPrint('✅ [Controller] File picked successfully: ${result.file?.path}');
        return result;
      }
      debugPrint('❌ [Controller] File picking failed: ${result.error}');
      throw result.error ?? 'Failed to pick file';
    });
  }
}