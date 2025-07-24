// lib/features/documents/presentation/widgets/document_detail/file_viewer_widget.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../core/database/app_database.dart';
import '../../helpers/file_viewer_helpers.dart';
import 'pdf_viewer_widget.dart';

class FileViewerWidget extends StatelessWidget {
  final Document document;
  final bool isFullScreen;

  const FileViewerWidget({
    super.key,
    required this.document,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!FileViewerHelpers.fileExists(document.filePath)) {
      return _buildErrorView(context, FileViewerHelpers.getFileErrorInfo(document.filePath));
    }

    final typeInfo = FileViewerHelpers.getFileTypeInfo(document.filePath);
    
    switch (typeInfo.type) {
      case FileType.image:
        return _buildImageViewer(context);
      case FileType.pdf:
        return _buildPdfViewer(context);
      case FileType.other:
        return _buildOtherFilePlaceholder(context, typeInfo);
    }
  }

  Widget _buildImageViewer(BuildContext context) {
    final file = File(document.filePath);
    
    // --- FIX: Removed the Container and its height/margin constraints ---
    // The InteractiveViewer allows for pinch-to-zoom and panning.
    return InteractiveViewer(
      minScale: 0.5,
      maxScale: 4.0,
      child: Center(
        child: Image.file(
          file,
          fit: BoxFit.contain,
          // Using a frameBuilder to show a loading indicator while the image loads.
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: frame == null
                  ? const Center(child: CircularProgressIndicator())
                  : child,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorView(
              context,
              const FileErrorInfo(
                type: FileErrorType.unknown,
                title: 'Error loading image',
                message: 'The image may be corrupted or in an unsupported format.',
                icon: Icons.broken_image,
                color: Colors.red,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPdfViewer(BuildContext context) {
    // Pass the isFullScreen parameter to allow full-screen PDF viewing
    return PdfViewerWidget(
      filePath: document.filePath,
      documentTitle: document.title,
      isFullScreen: isFullScreen,
    );
  }

  // --- The helper methods below remain largely the same, but without height/margin ---

  Widget _buildOtherFilePlaceholder(BuildContext context, FileTypeInfo typeInfo) {
    final placeholderInfo = FileViewerHelpers.getPlaceholderInfo(typeInfo);
    
    return Container(
      // Removed height and margin
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            placeholderInfo.icon,
            size: 64,
            color: placeholderInfo.color,
          ),
          const SizedBox(height: 16),
          Text(
            placeholderInfo.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              placeholderInfo.subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          if (placeholderInfo.actionText != null) ...[
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => _handleExternalOpen(context),
              icon: const Icon(Icons.open_in_new),
              label: Text(placeholderInfo.actionText!),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, FileErrorInfo errorInfo) {
    return Container(
      // Removed height and margin
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            errorInfo.icon,
            size: 64,
            color: errorInfo.color,
          ),
          const SizedBox(height: 16),
          Text(
            errorInfo.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: errorInfo.color,
                ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              errorInfo.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _handleExternalOpen(BuildContext context) {
    // TODO: Implement external file opening
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('External file opening will be implemented in a future update'),
      ),
    );
  }
}
