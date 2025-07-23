// lib/core/services/file_picker_service.dart

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // <-- Add this import

// --- ADD THIS LINE ---
final filePickerServiceProvider = Provider<FilePickerService>((ref) => FilePickerService());

class FilePickerResult {
  final File? file;
  final String? error;
  final String? fileName;
  final String? fileExtension;

  FilePickerResult({
    this.file,
    this.error,
    this.fileName,
    this.fileExtension,
  });

  bool get isSuccess => file != null && error == null;
  bool get hasError => error != null;
}

class FilePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  /// Pick an image from the camera
  Future<FilePickerResult> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image == null) {
        return FilePickerResult(error: 'No image selected');
      }

      final file = File(image.path);
      final fileName = image.name;
      final extension = fileName.split('.').last.toLowerCase();

      return FilePickerResult(
        file: file,
        fileName: fileName,
        fileExtension: extension,
      );
    } catch (e) {
      return FilePickerResult(error: 'Failed to take photo: ${e.toString()}');
    }
  }

  /// Pick an image from the gallery
  Future<FilePickerResult> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image == null) {
        return FilePickerResult(error: 'No image selected');
      }

      final file = File(image.path);
      final fileName = image.name;
      final extension = fileName.split('.').last.toLowerCase();

      return FilePickerResult(
        file: file,
        fileName: fileName,
        fileExtension: extension,
      );
    } catch (e) {
      return FilePickerResult(error: 'Failed to pick image: ${e.toString()}');
    }
  }

  /// Pick a file (PDF or images)
  Future<FilePickerResult> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'webp'],
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return FilePickerResult(error: 'No file selected');
      }

      final platformFile = result.files.first;
      final filePath = platformFile.path;

      if (filePath == null) {
        return FilePickerResult(error: 'Invalid file path');
      }

      final file = File(filePath);
      final fileName = platformFile.name;
      final extension = platformFile.extension?.toLowerCase();

      return FilePickerResult(
        file: file,
        fileName: fileName,
        fileExtension: extension,
      );
    } catch (e) {
      return FilePickerResult(error: 'Failed to pick file: ${e.toString()}');
    }
  }

  /// Check if the file is an image
  bool isImageFile(String? extension) {
    if (extension == null) return false;
    return ['jpg', 'jpeg', 'png', 'webp'].contains(extension.toLowerCase());
  }

  /// Check if the file is a PDF
  bool isPdfFile(String? extension) {
    if (extension == null) return false;
    return extension.toLowerCase() == 'pdf';
  }

  /// Get a display name for the file without extension
  String getDisplayName(String fileName) {
    final lastDot = fileName.lastIndexOf('.');
    if (lastDot > 0) {
      return fileName.substring(0, lastDot);
    }
    return fileName;
  }

  /// Validate file size (max 10MB)
  bool isValidFileSize(File file) {
    final sizeInBytes = file.lengthSync();
    final sizeInMB = sizeInBytes / (1024 * 1024);
    return sizeInMB <= 10;
  }
}
