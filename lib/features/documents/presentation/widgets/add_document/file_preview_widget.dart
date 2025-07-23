import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/services/file_picker_service.dart';

class FilePreviewWidget extends ConsumerWidget {
  final FilePickerResult fileResult;

  const FilePreviewWidget({super.key, required this.fileResult});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final filePickerService = ref.read(filePickerServiceProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            filePickerService.isPdfFile(fileResult.fileExtension)
                ? Icons.picture_as_pdf_rounded
                : Icons.image_rounded,
            color: colorScheme.primary,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileResult.fileName ?? 'Unknown file',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  _getFileTypeDisplay(filePickerService, fileResult.fileExtension),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getFileTypeDisplay(FilePickerService service, String? extension) {
    if (extension == null) return 'Unknown format';
    if (service.isPdfFile(extension)) return 'PDF Document';
    if (service.isImageFile(extension)) return 'Image (${extension.toUpperCase()})';
    return extension.toUpperCase();
  }
}
