// lib/features/documents/presentation/widgets/edit_document/edit_document_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/app_database.dart';
import '../../controllers/edit_form_controller.dart';
import '../../controllers/edit_document_controller.dart';
import 'form_fields/title_field.dart';
import 'form_fields/description_field.dart';
import 'form_fields/favorite_toggle.dart';
import 'form_fields/document_info_display.dart';

class EditDocumentForm extends ConsumerWidget {
  final Document document;

  const EditDocumentForm({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(editFormControllerProvider(document));
    final editState = ref.watch(editDocumentControllerProvider(document));
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title field
          TitleField(document: document),
          
          const SizedBox(height: 16),
          
          // Description field
          DescriptionField(document: document),
          
          const SizedBox(height: 24),
          
          // Favorite toggle
          FavoriteToggle(document: document),
          
          const SizedBox(height: 24),
          
          // Document information display
          DocumentInfoDisplay(document: document),
          
          const SizedBox(height: 24),
          
          // Validation errors summary (if any)
          if (formState.validationErrors?.isNotEmpty == true) ...[
            _buildErrorSummary(formState.validationErrors!),
            const SizedBox(height: 16),
          ],
          
          // Changes summary (if there are unsaved changes)
          if (editState.hasUnsavedChanges) ...[
            _buildChangesSummary(context, editState.changesSummary),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorSummary(Map<String, String> errors) {
    return Card(
      color: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Please fix the following errors:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...errors.entries.map((entry) => Padding(
              padding: const EdgeInsets.only(left: 28, bottom: 4),
              child: Text(
                '• ${entry.value}',
                style: TextStyle(color: Colors.red.shade700),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildChangesSummary(BuildContext context, String? summary) {
    if (summary == null || summary.isEmpty) return const SizedBox.shrink();
    
    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit_outlined, 
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Unsaved Changes:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              summary,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
