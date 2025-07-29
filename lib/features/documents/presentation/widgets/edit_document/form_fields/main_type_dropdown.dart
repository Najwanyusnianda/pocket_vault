// lib/features/documents/presentation/widgets/edit_document/form_fields/main_type_dropdown.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../../../../core/database/models/document_type.dart';
import '../../../controllers/edit_document_controller.dart';

class MainTypeDropdown extends ConsumerWidget {
  final Document document;

  const MainTypeDropdown({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editDocumentControllerProvider(document));
    final editController = ref.read(editDocumentControllerProvider(document).notifier);
    
    return DropdownButtonFormField<MainType>(
      value: editState.formData?.mainType,
      decoration: const InputDecoration(
        labelText: 'Document Type',
        hintText: 'Select document category',
        prefixIcon: Icon(Icons.category),
        border: OutlineInputBorder(),
      ),
      items: MainType.values.map((type) {
        return DropdownMenuItem<MainType>(
          value: type,
          child: Text(_getMainTypeDisplayName(type)),
        );
      }).toList(),
      onChanged: (MainType? value) {
        editController.updateDocumentType(value);
      },
    );
  }

  String _getMainTypeDisplayName(MainType type) {
    switch (type) {
      case MainType.identification:
        return 'Identification';
      case MainType.vehicle:
        return 'Vehicle';
      case MainType.financial:
        return 'Financial';
      case MainType.travel:
        return 'Travel';
      case MainType.legal:
        return 'Legal';
      case MainType.medical:
        return 'Medical';
      case MainType.other:
        return 'Other';
    }
  }
}
