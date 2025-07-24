// lib/features/documents/presentation/widgets/add_document/document_form_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/database/models/document_type.dart';
import '../../../../../core/services/file_picker_service.dart';
import 'file_preview_widget.dart';
import '../../helpers/form_helpers.dart';
import '../../helpers/document_type_helpers.dart';

class DocumentFormWidget extends ConsumerStatefulWidget {
  final FilePickerResult? fileResult;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final MainType? selectedMainType;
  final ValueChanged<MainType?> onMainTypeChanged;

  const DocumentFormWidget({
    super.key,
    required this.fileResult,
    required this.formKey,
    required this.titleController,
    required this.selectedMainType,
    required this.onMainTypeChanged,
  });

  @override
  ConsumerState<DocumentFormWidget> createState() => _DocumentFormWidgetState();
}

class _DocumentFormWidgetState extends ConsumerState<DocumentFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // File preview (if file provided)
            if (widget.fileResult != null) ...[
              FilePreviewWidget(fileResult: widget.fileResult!),
              const SizedBox(height: 24),
            ],

            // Title field
            TextFormField(
              controller: widget.titleController,
              decoration: const InputDecoration(
                labelText: 'Document Title *',
                hintText: 'Enter a descriptive title',
                prefixIcon: Icon(Icons.title),
              ),
              validator: FormHelpers.validateTitle,
              textCapitalization: TextCapitalization.words,
              maxLength: 100,
            ),
            const SizedBox(height: 16),

            // Document type selector
            _buildDocumentTypeSelector(),

            // Add bottom padding for save button
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentTypeSelector() {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Document Type',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: MainType.values.map((type) {
            final isSelected = widget.selectedMainType == type;
            return FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    type.getIcon(),
                    size: 16,
                    color: isSelected
                        ? theme.colorScheme.onSecondaryContainer
                        : type.getColor(context),
                  ),
                  const SizedBox(width: 4),
                  Text(type.getName()),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                widget.onMainTypeChanged(selected ? type : null);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
