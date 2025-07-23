// lib/features/documents/presentation/widgets/edit_document/edit_document_app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/database/app_database.dart';
import '../../controllers/edit_document_controller.dart';

class EditDocumentAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Document document;

  const EditDocumentAppBar({
    super.key,
    required this.document,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerState = ref.watch(editDocumentControllerProvider(document));
    final controller = ref.read(editDocumentControllerProvider(document).notifier);
    
    return AppBar(
      title: const Text('Edit Document'),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => _handleClose(context, controller),
      ),
      actions: [
        // Reset button (if there are unsaved changes)
        if (controllerState.hasUnsavedChanges) ...[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controllerState.isSaving 
                ? null 
                : () => _handleReset(ref, controller),
            tooltip: 'Reset to original',
          ),
        ],
        
        // Save button
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextButton(
            onPressed: controllerState.isSaving 
                ? null 
                : () => _handleSave(context, controller),
            child: controllerState.isSaving
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    controllerState.hasUnsavedChanges ? 'Save' : 'Save',
                    style: TextStyle(
                      fontWeight: controllerState.hasUnsavedChanges 
                          ? FontWeight.w600 
                          : FontWeight.normal,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  void _handleClose(BuildContext context, EditDocumentController controller) async {
    final canClose = await controller.handleBackNavigation(context);
    if (canClose && context.mounted) {
      context.pop();
    }
  }

  void _handleSave(BuildContext context, EditDocumentController controller) {
    controller.saveDocument(context);
  }

  void _handleReset(WidgetRef ref, EditDocumentController controller) {
    _showResetConfirmation(ref.context, controller);
  }

  void _showResetConfirmation(BuildContext context, EditDocumentController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Changes'),
        content: const Text(
          'Are you sure you want to reset all changes? This will restore the original values.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              controller.resetForm();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Form reset to original values'),
                ),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
