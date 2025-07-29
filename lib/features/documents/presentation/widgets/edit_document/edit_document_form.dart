// lib/features/documents/presentation/widgets/edit_document/edit_document_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/app_database.dart';
import '../../controllers/edit_document_controller.dart';

// Import card components
import 'cards/main_details_card.dart';
import 'cards/attributes_card.dart';
import 'cards/custom_fields_card.dart';

class EditDocumentForm extends ConsumerWidget {
  final Document document;

  const EditDocumentForm({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editDocumentControllerProvider(document));
    final editController = ref.read(editDocumentControllerProvider(document).notifier);
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Main Details Card (Title & Description)
          MainDetailsCard(document: document),
          
          // Attributes Card (Type, Expiration, Tags)
          AttributesCard(document: document),
          
          // Custom Fields Card (Dynamic based on subType)
          CustomFieldsCard(document: document),
          
          // Actions Card (Favorite, Archive toggles)
          // ActionsCard(document: document),
          
          // Information Section (Read-only data)
          //InformationSection(document: document),
          
          // Error Summary
          if (editState.validation?.errors.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            _buildErrorSummary(editState.validation!.errors),
          ],
          
          // Changes Summary
          if (editState.hasUnsavedChanges) ...[
            const SizedBox(height: 8),
            _buildChangesSummary(context, editController.getChangesSummary()),
          ],
          
          // Bottom padding for better scrolling
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildErrorSummary(Map<String, String> errors) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: Colors.red.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade700, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Please fix the following errors:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...errors.entries.map((entry) => Padding(
                padding: const EdgeInsets.only(left: 36, bottom: 6),
                child: Text(
                  '• ${entry.value}',
                  style: TextStyle(color: Colors.red.shade700),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangesSummary(BuildContext context, String? summary) {
    if (summary == null || summary.isEmpty) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha:0.5),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit_outlined, 
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Unsaved Changes:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: Text(
                  summary,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
