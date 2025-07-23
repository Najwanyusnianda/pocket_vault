// lib/features/documents/presentation/widgets/document_detail/document_detail_app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/app_database.dart';
import '../../controllers/document_detail_controller.dart';

class DocumentDetailAppBar extends ConsumerWidget {
  final Document document;

  const DocumentDetailAppBar({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerState = ref.watch(documentDetailControllerProvider(document.id));
    
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          document.title,
          style: const TextStyle(fontSize: 16),
        ),
        titlePadding: const EdgeInsets.only(left: 72, bottom: 16),
      ),
      actions: [
        // Edit button
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: controllerState.isDeleting 
              ? null 
              : () => _handleEdit(context, ref),
          tooltip: 'Edit Document',
        ),
        // Delete button
        IconButton(
          icon: controllerState.isDeleting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.delete_outline),
          onPressed: controllerState.isDeleting 
              ? null 
              : () => _handleDelete(context, ref),
          tooltip: 'Delete Document',
        ),
        // More actions menu
        PopupMenuButton<String>(
          onSelected: (value) => _handleMenuAction(context, ref, value),
          tooltip: 'More actions',
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'favorite',
              child: Row(
                children: [
                  Icon(
                    document.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(document.isFavorite ? 'Remove from favorites' : 'Add to favorites'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'archive',
              child: Row(
                children: [
                  Icon(
                    document.isArchived ? Icons.unarchive : Icons.archive,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(document.isArchived ? 'Unarchive' : 'Archive'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share, size: 18),
                  SizedBox(width: 8),
                  Text('Share'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'export',
              child: Row(
                children: [
                  Icon(Icons.download, size: 18),
                  SizedBox(width: 8),
                  Text('Export'),
                ],
              ),
            ),
          ],
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

  void _handleMenuAction(BuildContext context, WidgetRef ref, String action) {
    // Actions will be implemented with the document actions controller
    switch (action) {
      case 'favorite':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${document.isFavorite ? "Removed from" : "Added to"} favorites'),
          ),
        );
        break;
      case 'archive':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Document ${document.isArchived ? "unarchived" : "archived"}'),
          ),
        );
        break;
      case 'share':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Share functionality coming soon')),
        );
        break;
      case 'export':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export functionality coming soon')),
        );
        break;
    }
  }
}
