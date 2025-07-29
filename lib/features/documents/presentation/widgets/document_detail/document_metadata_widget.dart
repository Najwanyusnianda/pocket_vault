// lib/features/documents/presentation/widgets/document_detail/document_metadata_widget.dart

import 'package:flutter/material.dart';
import '../../../../../core/database/app_database.dart';
import '../../helpers/document_formatting_helpers.dart';
import '../../helpers/document_type_helpers.dart';

class DocumentMetadataWidget extends StatelessWidget {
  final Document document;

  const DocumentMetadataWidget({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with badges
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Document Information',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ..._buildStatusBadges(context),
              ],
            ),
            const SizedBox(height: 16),
            
            // Metadata rows
            ..._buildMetadataRows(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStatusBadges(BuildContext context) {
    final badges = DocumentFormattingHelpers.getDocumentBadges(document);
    
    return badges.map((badge) => Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Tooltip(
        message: badge.tooltip,
        child: Icon(
          badge.icon,
          size: 20,
          color: badge.color,
        ),
      ),
    )).toList();
  }

  List<Widget> _buildMetadataRows(BuildContext context) {
    final rows = <Widget>[];
    
    // Document Type
    if (document.mainType != null) {
      rows.add(DocumentMetadataRow(
        label: 'Type',
        value: document.mainType!.getName(),
        icon: document.mainType!.getIcon(),
        iconColor: document.mainType!.getColor(context),
      ));
      rows.add(const Divider(height: 24));
    }

    // Description
    if (document.description != null && document.description!.isNotEmpty) {
      rows.add(DocumentMetadataRow(
        label: 'Description',
        value: document.description!,
        icon: Icons.description,
        isMultiline: true,
      ));
      rows.add(const Divider(height: 24));
    }

    // Creation Date
    rows.add(DocumentMetadataRow(
      label: 'Created',
      value: DocumentFormattingHelpers.formatDateTime(document.creationDate),
      icon: Icons.calendar_today,
    ));
    rows.add(const Divider(height: 24));

    // Updated Date
    rows.add(DocumentMetadataRow(
      label: 'Last Updated',
      value: DocumentFormattingHelpers.formatDateTime(document.updatedDate),
      icon: Icons.update,
    ));

    // Expiration Date
    if (document.expirationDate != null) {
      final expirationStatus = DocumentFormattingHelpers.getExpirationStatus(document.expirationDate);
      rows.add(const Divider(height: 24));
      rows.add(DocumentMetadataRow(
        label: 'Expires',
        value: expirationStatus.text,
        icon: Icons.event_busy,
        iconColor: expirationStatus.color,
        valueColor: expirationStatus.isUrgent ? expirationStatus.color : null,
      ));
    }

    // File Information
    rows.add(const Divider(height: 24));
    rows.add(DocumentMetadataRow(
      label: 'File',
      value: DocumentFormattingHelpers.getFileDisplayName(document.filePath),
      icon: Icons.folder,
    ));

    return rows;
  }
}

class DocumentMetadataRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final Color? valueColor;
  final bool isMultiline;

  const DocumentMetadataRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.valueColor,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 20,
            color: iconColor ?? theme.colorScheme.onSurface.withValues(alpha:0.6),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha:0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: valueColor,
                ),
                maxLines: isMultiline ? null : 1,
                overflow: isMultiline ? null : TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
