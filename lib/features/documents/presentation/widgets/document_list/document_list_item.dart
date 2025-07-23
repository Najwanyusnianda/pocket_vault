// lib/features/documents/presentation/widgets/document_list/document_list_item.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/database/app_database.dart';
import '../../helpers/document_type_helpers.dart'; // <-- Import the new extension file

class DocumentListItem extends StatelessWidget {
  final Document document;

  const DocumentListItem({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // --- CHANGE: Replaced the Card with a Container using a bottom border for separation ---
    return InkWell(
      onTap: () => context.go('/document/${document.id}'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Document Type Icon
            _buildDocumentIcon(context),
            const SizedBox(width: 12),
            
            // Main content area
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getSubtitleText(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Status badges and actions
            _buildTrailingContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentIcon(BuildContext context) {
    // Use the extension methods to get icon and color
    final iconData = document.mainType.getIcon();
    final typeColor = document.mainType.getColor(context);

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: typeColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(iconData, size: 20, color: typeColor),
    );
  }

  Widget _buildTrailingContent(BuildContext context) {
    final badges = _buildStatusBadges(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (badges.isNotEmpty)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: badges,
          ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          iconSize: 20,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          onPressed: () {
            // TODO: Show actions menu
          },
        ),
      ],
    );
  }

  List<Widget> _buildStatusBadges(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    List<Widget> badges = [];

    if (document.isFavorite) {
      badges.add(_createBadge(Icons.favorite, colorScheme.error));
    }

    if (document.expirationDate != null) {
      final daysUntil = document.expirationDate!.difference(DateTime.now()).inDays;
      if (daysUntil >= 0 && daysUntil <= 7) {
        badges.add(_createBadge(Icons.schedule, colorScheme.tertiary));
      }
    }
    return badges;
  }

  Widget _createBadge(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Icon(icon, size: 16, color: color),
    );
  }

  String _getSubtitleText() {
    if (document.expirationDate != null) {
      final daysUntil = document.expirationDate!.difference(DateTime.now()).inDays;
      if (daysUntil == 0) return 'Expires today';
      if (daysUntil == 1) return 'Expires tomorrow';
      if (daysUntil > 1 && daysUntil <= 30) return 'Expires in $daysUntil days';
      if (daysUntil < 0) return 'Expired';
    }
    return document.mainType.getName(); // Use extension method
  }
}
