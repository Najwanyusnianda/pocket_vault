// lib/features/documents/presentation/widgets/document_detail/document_detail_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/app_database.dart';
import '../../../../../core/database/models/document_type.dart';
import '../../controllers/document_detail_controller.dart';
import '../../helpers/document_formatting_helpers.dart';
import '../../helpers/document_type_helpers.dart';
import '../document_actions_menu.dart';

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
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag Handle
          _buildDragHandle(colorScheme),
          
          // Expanded content
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              children: [
                // Document Header with Icon and Title
                _buildDocumentHeader(context, theme),
                const SizedBox(height: 24),
                
                // Action Buttons Row
                _buildQuickActions(context, ref, controllerState, theme),
                const SizedBox(height: 32),
                
                // Document Information Cards
                _buildDocumentInfoSection(context, theme),
                const SizedBox(height: 24),
                
                // Metadata Section
                _buildMetadataSection(context, theme),
                const SizedBox(height: 24),
                
                // File Information Section
                _buildFileInfoSection(context, theme),
                
                // Description Section (if exists)
                if (document.description != null && document.description!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildDescriptionSection(context, theme),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragHandle(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      child: Container(
        width: 48,
        height: 4,
        decoration: BoxDecoration(
          color: colorScheme.onSurface.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildDocumentHeader(BuildContext context, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final documentIcon = document.mainType.getIcon();
    final documentColor = document.mainType.getColor(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Document type icon
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: documentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            documentIcon,
            size: 28,
            color: documentColor,
          ),
        ),
        const SizedBox(width: 16),
        
        // Title and basic info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Document title
              Text(
                document.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              
              // Document type and subtype
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: documentColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: documentColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      document.mainType?.getName() ?? 'Unknown',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: documentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (document.subType != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getSubTypeDisplayName(document.subType!),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              
              // Favorite indicator
              if (document.isFavorite) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 16,
                      color: colorScheme.error,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Favorite',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref, DocumentDetailState controllerState, ThemeData theme) {
    return Row(
      children: [
        // Copy button
        Expanded(
          child: FilledButton.tonalIcon(
            onPressed: () => _copyDocumentInfo(context),
            icon: const Icon(Icons.copy_rounded, size: 20),
            label: const Text('Copy Info'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        
        // Edit button
        Expanded(
          child: FilledButton.icon(
            onPressed: controllerState.isDeleting 
                ? null 
                : () => _handleEdit(context, ref),
            icon: const Icon(Icons.edit_rounded, size: 20),
            label: const Text('Edit'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        
        // More actions menu
        DocumentActionsMenu(
          documentId: document.id,
          documentTitle: document.title,
          isFavorite: document.isFavorite,
          onEdit: () => _handleEdit(context, ref),
          onDeleted: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildDocumentInfoSection(BuildContext context, ThemeData theme) {
    return _buildSection(
      context: context,
      theme: theme,
      title: 'Document Status',
      icon: Icons.info_outline_rounded,
      children: [
        Row(
          children: [
            // Expiration status
            if (document.expirationDate != null) ...[
              Expanded(
                child: _buildStatusCard(
                  context: context,
                  theme: theme,
                  title: 'Expires',
                  value: _getExpirationStatus(),
                  icon: Icons.schedule_rounded,
                  color: _getExpirationColor(context),
                ),
              ),
              const SizedBox(width: 12),
            ],
            
            // Archive status
            Expanded(
              child: _buildStatusCard(
                context: context,
                theme: theme,
                title: 'Status',
                value: document.isArchived ? 'Archived' : 'Active',
                icon: document.isArchived ? Icons.archive_rounded : Icons.check_circle_rounded,
                color: document.isArchived ? theme.colorScheme.tertiary : theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetadataSection(BuildContext context, ThemeData theme) {
    return _buildSection(
      context: context,
      theme: theme,
      title: 'Dates & Times',
      icon: Icons.schedule_outlined,
      children: [
        _buildInfoRow(
          context: context,
          theme: theme,
          label: 'Created',
          value: DocumentFormattingHelpers.formatDateTime(document.creationDate),
          icon: Icons.add_circle_outline_rounded,
        ),
        
        if (document.updatedDate != document.creationDate)
          _buildInfoRow(
            context: context,
            theme: theme,
            label: 'Modified',
            value: DocumentFormattingHelpers.formatDateTime(document.updatedDate),
            icon: Icons.edit_calendar_outlined,
          ),
        
        if (document.expirationDate != null)
          _buildInfoRow(
            context: context,
            theme: theme,
            label: 'Expires',
            value: DocumentFormattingHelpers.formatDateTime(document.expirationDate!),
            icon: Icons.event_busy_rounded,
            valueColor: _getExpirationColor(context),
          ),
      ],
    );
  }

  Widget _buildFileInfoSection(BuildContext context, ThemeData theme) {
    return _buildSection(
      context: context,
      theme: theme,
      title: 'File Information',
      icon: Icons.insert_drive_file_outlined,
      children: [
        _buildInfoRow(
          context: context,
          theme: theme,
          label: 'Name',
          value: DocumentFormattingHelpers.getFileDisplayName(document.filePath),
          icon: Icons.description_outlined,
        ),
        
        _buildInfoRow(
          context: context,
          theme: theme,
          label: 'Location',
          value: document.filePath.split('/').last,
          icon: Icons.folder_outlined,
        ),
        
        if (document.thumbnailPath != null)
          _buildInfoRow(
            context: context,
            theme: theme,
            label: 'Thumbnail',
            value: 'Available',
            icon: Icons.image_outlined,
          ),
      ],
    );
  }

  Widget _buildDescriptionSection(BuildContext context, ThemeData theme) {
    return _buildSection(
      context: context,
      theme: theme,
      title: 'Description',
      icon: Icons.description_outlined,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Text(
            document.description!,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required ThemeData theme,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required BuildContext context,
    required ThemeData theme,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: color,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required ThemeData theme,
    required String label,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: valueColor ?? theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  String _getExpirationStatus() {
    if (document.expirationDate == null) return 'No expiration';
    
    final now = DateTime.now();
    final expiration = document.expirationDate!;
    final difference = expiration.difference(now).inDays;
    
    if (difference < 0) return 'Expired';
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference <= 7) return 'In $difference days';
    if (difference <= 30) return 'In $difference days';
    
    return 'In ${(difference / 30).ceil()} month(s)';
  }

  Color _getExpirationColor(BuildContext context) {
    if (document.expirationDate == null) return Theme.of(context).colorScheme.onSurfaceVariant;
    
    final now = DateTime.now();
    final expiration = document.expirationDate!;
    final difference = expiration.difference(now).inDays;
    
    if (difference < 0) return Theme.of(context).colorScheme.error;
    if (difference <= 7) return Theme.of(context).colorScheme.tertiary;
    return Theme.of(context).colorScheme.primary;
  }

  void _copyDocumentInfo(BuildContext context) {
    final info = '''
Document: ${document.title}
Type: ${document.mainType?.getName() ?? 'Unknown'}
Created: ${DocumentFormattingHelpers.formatDateTime(document.creationDate)}
${document.expirationDate != null ? 'Expires: ${DocumentFormattingHelpers.formatDateTime(document.expirationDate!)}' : ''}
${document.description != null && document.description!.isNotEmpty ? 'Description: ${document.description}' : ''}
'''.trim();

    Clipboard.setData(ClipboardData(text: info));
    HapticFeedback.lightImpact();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Document information copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleEdit(BuildContext context, WidgetRef ref) {
    HapticFeedback.lightImpact();
    final controller = ref.read(documentDetailControllerProvider(document.id).notifier);
    controller.navigateToEdit(context, document);
  }

  String _getSubTypeDisplayName(SubType subType) {
    switch (subType) {
      case SubType.passport:
        return 'Passport';
      case SubType.nationalId:
        return 'National ID';
      case SubType.driversLicense:
        return 'Driver\'s License';
      case SubType.birthCertificate:
        return 'Birth Certificate';
      case SubType.carRegistration:
        return 'Car Registration';
      case SubType.carInsurance:
        return 'Car Insurance';
      case SubType.creditCard:
        return 'Credit Card';
      case SubType.bankStatement:
        return 'Bank Statement';
      case SubType.taxDocument:
        return 'Tax Document';
      case SubType.visa:
        return 'Visa';
      case SubType.boardingPass:
        return 'Boarding Pass';
      case SubType.hotelReservation:
        return 'Hotel Reservation';
      case SubType.genericDocument:
        return 'Generic Document';
    }
  }
}
