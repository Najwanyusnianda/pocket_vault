// lib/features/documents/presentation/widgets/edit_document/form_fields/title_field.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../controllers/edit_form_controller.dart';
import '../../../controllers/edit_form_state.dart';

class TitleField extends ConsumerWidget {
  final Document document;

  const TitleField({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(editFormControllerProvider(document));
    final formController = ref.read(editFormControllerProvider(document).notifier);
    
    final titleError = formState.validationErrors['title'];
    final titleLength = formState.formData!.title.length;
    const maxLength = 255;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: formController.titleController,
          maxLength: maxLength,
          decoration: InputDecoration(
            labelText: 'Document Title *',
            hintText: 'Enter a descriptive title for your document',
            errorText: titleError,
            suffixIcon: titleLength > 0
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => formController.titleController.clear(),
                    tooltip: 'Clear title',
                  )
                : null,
            border: const OutlineInputBorder(),
            counterText: '$titleLength/$maxLength',
            counterStyle: TextStyle(
              color: titleLength > maxLength * 0.8
                  ? titleLength >= maxLength
                      ? Colors.red
                      : Colors.orange
                  : null,
            ),
          ),
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            formController.updateTitle(value);
          },
        ),
        
        // Character count warning
        if (titleLength > maxLength * 0.8) ...[
          const SizedBox(height: 4),
          _buildCharacterWarning(titleLength, maxLength),
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
      warningText = 'Title is ${-remaining} characters too long';
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
}
