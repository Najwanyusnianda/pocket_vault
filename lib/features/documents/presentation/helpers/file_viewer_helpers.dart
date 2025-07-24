// lib/features/documents/presentation/helpers/file_viewer_helpers.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/services/file_picker_service.dart';

/// Helper class for file viewing operations
class FileViewerHelpers {
  FileViewerHelpers._();

  /// Gets the file extension from a file path
  static String getFileExtension(String filePath) {
    return filePath.split('.').last.toLowerCase();
  }

  /// Checks if a file exists at the given path
  static bool fileExists(String filePath) {
    return File(filePath).existsSync();
  }

  /// Gets the file type information for display
  static FileTypeInfo getFileTypeInfo(String filePath) {
    final extension = getFileExtension(filePath);
    final filePickerService = FilePickerService();

    if (filePickerService.isImageFile(extension)) {
      return FileTypeInfo(
        type: FileType.image,
        displayName: 'Image',
        icon: Icons.image,
        color: Colors.blue,
        canPreview: true,
      );
    } else if (filePickerService.isPdfFile(extension)) {
      return FileTypeInfo(
        type: FileType.pdf,
        displayName: 'PDF Document',
        icon: Icons.picture_as_pdf,
        color: Colors.red,
        canPreview: true, // Changed from false - PDF viewer is now implemented
      );
    } else {
      return FileTypeInfo(
        type: FileType.other,
        displayName: '${extension.toUpperCase()} File',
        icon: Icons.insert_drive_file,
        color: Colors.grey,
        canPreview: false,
      );
    }
  }

  /// Gets appropriate error info for file viewing issues
  static FileErrorInfo getFileErrorInfo(String filePath) {
    if (!fileExists(filePath)) {
      return FileErrorInfo(
        type: FileErrorType.notFound,
        title: 'File not found',
        message: 'The file could not be located at the specified path.',
        icon: Icons.error_outline,
        color: Colors.grey,
      );
    }

    try {
      final file = File(filePath);
      if (file.lengthSync() == 0) {
        return FileErrorInfo(
          type: FileErrorType.empty,
          title: 'Empty file',
          message: 'The file appears to be empty.',
          icon: Icons.warning,
          color: Colors.orange,
        );
      }
    } catch (e) {
      return FileErrorInfo(
        type: FileErrorType.accessDenied,
        title: 'Cannot access file',
        message: 'Permission denied or file is in use.',
        icon: Icons.lock,
        color: Colors.red,
      );
    }

    return FileErrorInfo(
      type: FileErrorType.unknown,
      title: 'Unknown error',
      message: 'An unexpected error occurred while accessing the file.',
      icon: Icons.error,
      color: Colors.red,
    );
  }

  /// Gets the appropriate placeholder info for unsupported file types
  static FilePlaceholderInfo getPlaceholderInfo(FileTypeInfo typeInfo) {
    switch (typeInfo.type) {
      case FileType.pdf:
        return FilePlaceholderInfo(
          title: 'PDF Document',
          subtitle: 'PDF viewer will be implemented in a future update',
          icon: Icons.picture_as_pdf,
          color: Colors.red,
          actionText: 'Open Externally',
        );
      case FileType.other:
        return FilePlaceholderInfo(
          title: typeInfo.displayName,
          subtitle: 'Preview not available for this file type',
          icon: typeInfo.icon,
          color: typeInfo.color,
          actionText: 'Open Externally',
        );
      case FileType.image:
        return FilePlaceholderInfo(
          title: 'Image Loading',
          subtitle: 'Please wait...',
          icon: Icons.image,
          color: Colors.blue,
          actionText: null,
        );
    }
  }

  /// Determines if the file can be previewed in the app
  static bool canPreviewFile(String filePath) {
    final typeInfo = getFileTypeInfo(filePath);
    return typeInfo.canPreview && fileExists(filePath);
  }

  /// Gets the MIME type for a file
  static String getMimeType(String filePath) {
    final extension = getFileExtension(filePath);
    
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'pdf':
        return 'application/pdf';
      case 'txt':
        return 'text/plain';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      default:
        return 'application/octet-stream';
    }
  }
}

/// Enum for different file types
enum FileType {
  image,
  pdf,
  other,
}

/// Enum for different file error types
enum FileErrorType {
  notFound,
  empty,
  accessDenied,
  unknown,
}

/// Data class for file type information
class FileTypeInfo {
  final FileType type;
  final String displayName;
  final IconData icon;
  final Color color;
  final bool canPreview;

  const FileTypeInfo({
    required this.type,
    required this.displayName,
    required this.icon,
    required this.color,
    required this.canPreview,
  });
}

/// Data class for file error information
class FileErrorInfo {
  final FileErrorType type;
  final String title;
  final String message;
  final IconData icon;
  final Color color;

  const FileErrorInfo({
    required this.type,
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
  });
}

/// Data class for file placeholder information
class FilePlaceholderInfo {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? actionText;

  const FilePlaceholderInfo({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.actionText,
  });
}
