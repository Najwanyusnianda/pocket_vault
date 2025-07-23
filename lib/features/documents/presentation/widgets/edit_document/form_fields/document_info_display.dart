// lib/features/documents/presentation/widgets/edit_document/form_fields/document_info_display.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../helpers/document_type_helpers.dart';

class DocumentInfoDisplay extends ConsumerWidget {
  final Document document;

  const DocumentInfoDisplay({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Document Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            
            // Document type
            _buildInfoRow(
              context,
              icon: Icons.category_outlined,
              label: 'Type',
              // --- FIX: Used getName() and getColor() from the helper extension ---
              value: document.mainType.getName(),
              valueColor: document.mainType.getColor(context),
            ),
            
            const SizedBox(height: 12),
            
            // File path
            _buildInfoRow(
              context,
              icon: Icons.folder_outlined,
              label: 'File Path',
              value: document.filePath,
              isPath: true,
            ),
            
            const SizedBox(height: 12),
            
            // Creation date
            _buildInfoRow(
              context,
              icon: Icons.create_outlined,
              label: 'Created',
              // --- FIX: Changed createdAt to creationDate ---
              value: _formatDateTime(document.creationDate),
            ),
            
            const SizedBox(height: 12),
            
            // Last modified
            _buildInfoRow(
              context,
              icon: Icons.edit_outlined,
              label: 'Last Modified',
              // --- FIX: Changed updatedAt to updatedDate ---
              value: _formatDateTime(document.updatedDate),
            ),
            
            // Expiration date (if applicable)
            if (document.expirationDate != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                context,
                icon: Icons.schedule_outlined,
                label: 'Expires',
                value: _formatDate(document.expirationDate!),
                valueColor: _getExpirationColor(document.expirationDate!),
                suffix: _getExpirationWarning(document.expirationDate!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    bool isPath = false,
    Widget? suffix,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: valueColor,
                      fontFamily: isPath ? 'monospace' : null,
                      fontSize: isPath ? 12 : null,
                    ),
              ),
              if (suffix != null) ...[
                const SizedBox(height: 4),
                suffix,
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays == 0) {
      return 'Today at ${DateFormat.Hm().format(dateTime)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${DateFormat.Hm().format(dateTime)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat.yMMMd().add_Hm().format(dateTime);
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  Color? _getExpirationColor(DateTime expirationDate) {
    final now = DateTime.now();
    final daysUntilExpiration = expirationDate.difference(now).inDays;
    
    if (daysUntilExpiration < 0) {
      return Colors.red; // Expired
    } else if (daysUntilExpiration <= 7) {
      return Colors.orange; // Expiring soon
    } else if (daysUntilExpiration <= 30) {
      return Colors.amber; // Expiring in a month
    }
    return null; // Normal
  }

  Widget? _getExpirationWarning(DateTime expirationDate) {
    final now = DateTime.now();
    final daysUntilExpiration = expirationDate.difference(now).inDays;
    
    String warningText;
    Color warningColor;
    IconData warningIcon;
    
    if (daysUntilExpiration < 0) {
      warningText = 'Expired ${-daysUntilExpiration} days ago';
      warningColor = Colors.red;
      warningIcon = Icons.error;
    } else if (daysUntilExpiration == 0) {
      warningText = 'Expires today';
      warningColor = Colors.red;
      warningIcon = Icons.warning;
    } else if (daysUntilExpiration <= 7) {
      warningText = 'Expires in $daysUntilExpiration days';
      warningColor = Colors.orange;
      warningIcon = Icons.warning;
    } else if (daysUntilExpiration <= 30) {
      warningText = 'Expires in $daysUntilExpiration days';
      warningColor = Colors.amber;
      warningIcon = Icons.info;
    } else {
      return null;
    }
    
    return Row(
      children: [
        Icon(warningIcon, size: 14, color: warningColor),
        const SizedBox(width: 4),
        Text(
          warningText,
          style: TextStyle(
            color: warningColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
