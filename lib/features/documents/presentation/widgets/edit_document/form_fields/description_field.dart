// lib/features/documents/presentation/widgets/edit_document/form_fields/description_field.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../controllers/edit_form_controller.dart';

class DescriptionField extends ConsumerWidget {
  final Document document;

  const DescriptionField({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(editFormControllerProvider(document));
    final formController = ref.read(editFormControllerProvider(document).notifier);
    
    final descriptionError = formState.validationErrors?['description'];
    final descriptionLength = formState.formData.description?.length ?? 0;
    const maxLength = 1000;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: formController.descriptionController,
          maxLength: maxLength,
          maxLines: 5,
          minLines: 3,
          decoration: InputDecoration(
            labelText: 'Description',
            hintText: 'Add a detailed description (optional)',
            errorText: descriptionError,
            suffixIcon: descriptionLength > 0
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => formController.descriptionController.clear(),
                    tooltip: 'Clear description',
                  )
                : null,
            border: const OutlineInputBorder(),
            counterText: '$descriptionLength/$maxLength',
            counterStyle: TextStyle(
              color: descriptionLength > maxLength * 0.8
                  ? descriptionLength >= maxLength
                      ? Colors.red
                      : Colors.orange
                  : null,
            ),
            alignLabelWithHint: true,
          ),
          textCapitalization: TextCapitalization.sentences,
          onChanged: (value) {
            formController.updateDescription(value);
          },
        ),
        
        // Character count warning
        if (descriptionLength > maxLength * 0.8) ...[
          const SizedBox(height: 4),
          _buildCharacterWarning(descriptionLength, maxLength),
        ],
        
        // Helpful tips for description
        if (descriptionLength == 0) ...[
          const SizedBox(height: 8),
          _buildDescriptionTips(),
        ],
      ],
    );
  }

  Widget _buildCharacterWarning(int currentLength, int maxLength) {
    final remaining = maxLength - currentLength;
    final isOverLimit = remaining < 0;
    final isWarning = remaining <= maxLength * 0.2;
    
    Color warningColor;
    IconData warningIcon;
    String warningText;
    
    if (isOverLimit) {
      warningColor = Colors.red;
      warningIcon = Icons.error;
      warningText = 'Description is ${-remaining} characters too long';
    } else if (isWarning) {
      warningColor = Colors.orange;
      warningIcon = Icons.warning;
      warningText = 'Only $remaining characters remaining';
    } else {
      return const SizedBox.shrink();
    }
    
    return Row(
      children: [
        Icon(warningIcon, size: 16, color: warningColor),
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

  Widget _buildDescriptionTips() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, size: 16, color: Colors.blue.shade700),
              const SizedBox(width: 6),
              Text(
                'Tips for a good description:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ...const [
            '• Summarize the document\'s main content',
            '• Include relevant keywords for searching',
            '• Note important dates or deadlines',
            '• Add context that isn\'t obvious from the title',
          ].map((tip) => Padding(
            padding: const EdgeInsets.only(left: 22, bottom: 2),
            child: Text(
              tip,
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 11,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
