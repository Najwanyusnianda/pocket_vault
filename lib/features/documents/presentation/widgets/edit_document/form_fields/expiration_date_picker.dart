// lib/features/documents/presentation/widgets/edit_document/form_fields/expiration_date_picker.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../controllers/edit_document_controller.dart';

class ExpirationDatePicker extends ConsumerWidget {
  final Document document;

  const ExpirationDatePicker({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editDocumentControllerProvider(document));
    final editController = ref.read(editDocumentControllerProvider(document).notifier);
    
    final currentDate = editState.formData?.expirationDate;
    
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Expiration Date',
        hintText: 'Select expiration date (optional)',
        prefixIcon: const Icon(Icons.calendar_today),
        suffixIcon: currentDate != null
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => editController.updateExpirationDate(null),
                tooltip: 'Clear date',
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      controller: TextEditingController(
        text: currentDate != null
            ? '${currentDate.day}/${currentDate.month}/${currentDate.year}'
            : '',
      ),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: currentDate ?? DateTime.now().add(const Duration(days: 365)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
          helpText: 'Select expiration date',
        );
        
        if (selectedDate != null) {
          editController.updateExpirationDate(selectedDate);
        }
      },
    );
  }
}
