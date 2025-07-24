// lib/features/documents/presentation/widgets/document_detail/document_detail_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/app_database.dart';
import '../../controllers/document_detail_controller.dart';
import '../../helpers/document_formatting_helpers.dart';
import '../../helpers/document_type_helpers.dart';

class DocumentDetailSheet extends ConsumerWidget {
  final Document document;
  final ScrollController scrollController;

  const DocumentDetailSheet({
    super.key,
    required this.document,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final controllerState = ref.watch(documentDetailControllerProvider(document.id));

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        children: [
          // Drag Handle
          _buildDragHandle(context, colorScheme),
          const SizedBox(height: 16),

          // Header (Title & Actions)
          _buildHeader(context, ref, theme, controllerState),
          const Divider(height: 32),

          // Metadata
          _buildMetadata(context, theme),
          
          // Add bottom padding for comfortable scrolling
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDragHandle(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: colorScheme.onSurface.withOpacity(0.3),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, 
    WidgetRef ref, 
    ThemeData theme, 
    DocumentDetailState controllerState
  ) {
    return Row(
      children: [
        // Document Title
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                document.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Tap to expand details',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 8),
        
        // Action Buttons
        _buildActionButtons(context, ref, controllerState),
      ],
    );
  }

  Widget _buildActionButtons(
    BuildContext context, 
    WidgetRef ref, 
    DocumentDetailState controllerState
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Edit Button
        IconButton.filledTonal(
          onPressed: controllerState.isDeleting 
              ? null 
              : () => _handleEdit(context, ref),
          icon: const Icon(Icons.edit_outlined),
          tooltip: 'Edit Document',
        ),
        
        const SizedBox(width: 8),
        
        // Delete Button
        IconButton.filledTonal(
          onPressed: controllerState.isDeleting 
              ? null 
              : () => _handleDelete(context, ref),
          icon: controllerState.isDeleting
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                )
              : const Icon(Icons.delete_outline),
          tooltip: 'Delete Document',
        ),
      ],
    );
  }

  void _handleEdit(BuildContext context, WidgetRef ref) {
    final controller = ref.read(documentDetailControllerProvider(document.id).notifier);
    controller.navigateToEdit(context, document);
  }

  void _handleDelete(BuildContext context, WidgetRef ref) {
    final controller = ref.read(documentDetailControllerProvider(document.id).notifier);
    controller.deleteDocument(context);
  }

  Widget _buildMetadata(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          'Document Information',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        
        // Document Type
        _buildInfoRow(
          context,
          'Type',
          document.mainType?.getName() ?? 'Unknown',
          Icons.category_outlined,
          colorScheme,
        ),
        
        // Created Date
        _buildInfoRow(
          context,
          'Created',
          DocumentFormattingHelpers.formatDateTime(document.creationDate),
          Icons.calendar_today_outlined,
          colorScheme,
        ),
        
        // Modified Date
        if (document.updatedDate != document.creationDate)
          _buildInfoRow(
            context,
            'Modified',
            DocumentFormattingHelpers.formatDateTime(document.updatedDate),
            Icons.edit_calendar_outlined,
            colorScheme,
          ),
        
        // Description
        if (document.description != null && document.description!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'Description',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Text(
              document.description!,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
        
        // File Information
        const SizedBox(height: 16),
        Text(
          'File Information',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        
        _buildInfoRow(
          context,
          'File Path',
          DocumentFormattingHelpers.getFileDisplayName(document.filePath),
          Icons.insert_drive_file_outlined,
          colorScheme,
        ),
        
        // Add more metadata as needed
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
