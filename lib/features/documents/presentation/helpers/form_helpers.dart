// lib/features/documents/presentation/helpers/form_helpers.dart

import '../../../../core/services/file_picker_service.dart';

class FormHelpers {
  /// Extract display name from filename (without extension)
  static String getDisplayNameFromFile(FilePickerResult? fileResult) {
    if (fileResult?.fileName == null) return '';
    
    final fileName = fileResult!.fileName!;
    final lastDot = fileName.lastIndexOf('.');
    if (lastDot > 0) {
      return fileName.substring(0, lastDot);
    }
    return fileName;
  }

  /// Validate document title
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a document title';
    }
    if (value.trim().length < 2) {
      return 'Title must be at least 2 characters';
    }
    if (value.trim().length > 100) {
      return 'Title must be less than 100 characters';
    }
    return null;
  }

  /// Validate description (optional)
  static String? validateDescription(String? value) {
    if (value != null && value.trim().length > 500) {
      return 'Description must be less than 500 characters';
    }
    return null;
  }

  /// Check if file is valid
  static String? validateFile(FilePickerResult? fileResult) {
    if (fileResult?.file == null) {
      return 'No file selected';
    }

    final file = fileResult!.file!;
    
    // Check file size (max 10MB)
    final sizeInMB = file.lengthSync() / (1024 * 1024);
    if (sizeInMB > 10) {
      return 'File size must be less than 10MB';
    }

    // Check file extension
    final extension = fileResult.fileExtension?.toLowerCase();
    final allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'webp'];
    
    if (extension == null || !allowedExtensions.contains(extension)) {
      return 'Unsupported file type. Allowed: ${allowedExtensions.join(', ')}';
    }

    return null; // Valid file
  }

  /// Format file size for display
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Get file type display string
  static String getFileTypeDisplay(String? extension) {
    if (extension == null) return 'Unknown format';
    
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'PDF Document';
      case 'jpg':
      case 'jpeg':
        return 'JPEG Image';
      case 'png':
        return 'PNG Image';
      case 'webp':
        return 'WebP Image';
      default:
        return extension.toUpperCase();
    }
  }
}
