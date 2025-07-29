// lib/features/documents/presentation/widgets/document_actions_menu.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/document_actions_controller.dart';
import 'bundle_selection_dialog.dart';
import 'delete_confirmation_dialog.dart';

/// Three-dot actions menu for document items
class DocumentActionsMenu extends ConsumerWidget {
  final int documentId;
  final String documentTitle;
  final bool isFavorite;
  final VoidCallback? onEdit;
  final VoidCallback? onDeleted; // Callback when document is deleted

  const DocumentActionsMenu({
    super.key,
    required this.documentId,
    required this.documentTitle,
    required this.isFavorite,
    this.onEdit,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actionsController = ref.watch(documentActionsControllerProvider(documentId));
    final actionsNotifier = ref.read(documentActionsControllerProvider(documentId).notifier);

    // Listen to state changes and show messages
    ref.listen(documentActionsControllerProvider(documentId), (previous, next) {
      if (next.isSuccess || next.isError) {
        actionsNotifier.showMessage(context);
        if (next.isSuccess && next.message?.contains('deleted') == true && onDeleted != null) {
          // Navigate back or refresh list when document is deleted
          Future.delayed(const Duration(milliseconds: 500), onDeleted);
        }
      }
    });

    return PopupMenuButton<DocumentAction>(
      icon: Icon(
        Icons.more_vert,
        size: 20,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
      ),
      tooltip: 'Document actions',
      enabled: !actionsController.isLoading,
      onSelected: (action) => _handleAction(context, ref, action, actionsNotifier),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: DocumentAction.addToBundle,
          child: _buildMenuItemWithIcon(
            icon: Icons.folder_copy_rounded,
            text: 'Add to Bundle',
            context: context,
          ),
        ),
        PopupMenuItem(
          value: DocumentAction.toggleFavorite,
          child: _buildMenuItemWithIcon(
            icon: isFavorite ? Icons.favorite : Icons.favorite_border,
            text: isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
            context: context,
          ),
        ),
        PopupMenuItem(
          value: DocumentAction.share,
          child: _buildMenuItemWithIcon(
            icon: Icons.share_rounded,
            text: 'Share',
            context: context,
          ),
        ),
        PopupMenuItem(
          value: DocumentAction.edit,
          child: _buildMenuItemWithIcon(
            icon: Icons.edit_rounded,
            text: 'Edit',
            context: context,
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: DocumentAction.delete,
          child: _buildMenuItemWithIcon(
            icon: Icons.delete_rounded,
            text: 'Delete',
            context: context,
            isDestructive: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItemWithIcon({
    required IconData icon,
    required String text,
    required BuildContext context,
    bool isDestructive = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = isDestructive ? colorScheme.error : colorScheme.onSurface;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: textColor,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Future<void> _handleAction(
    BuildContext context,
    WidgetRef ref,
    DocumentAction action,
    DocumentActionsController controller,
  ) async {
    switch (action) {
      case DocumentAction.addToBundle:
        await _showBundleSelectionDialog(context, controller);
        break;
        
      case DocumentAction.toggleFavorite:
        await controller.toggleFavorite();
        break;
        
      case DocumentAction.share:
        await controller.shareDocument();
        break;
        
      case DocumentAction.edit:
        if (onEdit != null) {
          onEdit!();
        } else {
          // Default edit navigation if no callback provided
          await controller.editDocument();
        }
        break;
        
      case DocumentAction.delete:
        await _showDeleteConfirmationDialog(context, controller);
        break;
    }
  }

  Future<void> _showBundleSelectionDialog(
    BuildContext context,
    DocumentActionsController controller,
  ) async {
    final selectedBundleId = await showDialog<int>(
      context: context,
      builder: (context) => BundleSelectionDialog(
        documentId: documentId,
        documentTitle: documentTitle,
      ),
    );

    if (selectedBundleId != null) {
      await controller.addToBundle(selectedBundleId);
    }
  }

  Future<void> _showDeleteConfirmationDialog(
    BuildContext context,
    DocumentActionsController controller,
  ) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        documentTitle: documentTitle,
      ),
    );

    if (shouldDelete == true) {
      await controller.deleteDocument();
    }
  }
}

/// Available document actions
enum DocumentAction {
  addToBundle,
  toggleFavorite,
  share,
  edit,
  delete,
}
