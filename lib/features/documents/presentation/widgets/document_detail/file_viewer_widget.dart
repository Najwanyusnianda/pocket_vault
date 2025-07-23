// lib/features/documents/presentation/widgets/document_detail/file_viewer_widget.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../core/database/app_database.dart';
import '../../helpers/file_viewer_helpers.dart';

class FileViewerWidget extends StatelessWidget {
  final Document document;
  final double? height;

  const FileViewerWidget({
    super.key,
    required this.document,
    this.height = 400,
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
        return _buildPdfPlaceholder(context, typeInfo);
      case FileType.other:
        return _buildOtherFilePlaceholder(context, typeInfo);
    }
  }

  Widget _buildImageViewer(BuildContext context) {
    final file = File(document.filePath);
    
    return Container(
      height: height,
      margin: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          file,
          fit: BoxFit.contain,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorView(
              context,
              const FileErrorInfo(
                type: FileErrorType.unknown,
                title: 'Error loading image',
                message: 'The image could not be loaded. It may be corrupted or in an unsupported format.',
                icon: Icons.broken_image,
                color: Colors.red,
              ),
            );
          },
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) return child;
            
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: frame == null
                  ? _buildLoadingView(context)
                  : child,
            );
          },
        ),
      ),
    );
  }

  Widget _buildPdfPlaceholder(BuildContext context, FileTypeInfo typeInfo) {
    final placeholderInfo = FileViewerHelpers.getPlaceholderInfo(typeInfo);
    
    return Container(
      height: height,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
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

  Widget _buildOtherFilePlaceholder(BuildContext context, FileTypeInfo typeInfo) {
    final placeholderInfo = FileViewerHelpers.getPlaceholderInfo(typeInfo);
    
    return Container(
      height: height,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
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
      height: height,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withOpacity(0.3),
        ),
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

  Widget _buildLoadingView(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
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
