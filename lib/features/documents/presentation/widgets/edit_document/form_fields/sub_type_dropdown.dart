// lib/features/documents/presentation/widgets/edit_document/form_fields/sub_type_dropdown.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../../../../core/database/models/document_type.dart';
import '../../../controllers/edit_document_controller.dart';

class SubTypeDropdown extends ConsumerWidget {
  final Document document;

  const SubTypeDropdown({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editDocumentControllerProvider(document));
    final editController = ref.read(editDocumentControllerProvider(document).notifier);
    
    final mainType = editState.formData?.mainType;
    if (mainType == null) return const SizedBox.shrink();
    
    final availableSubTypes = documentTypeHierarchy[mainType] ?? [];
    
    if (availableSubTypes.isEmpty) return const SizedBox.shrink();
    
    // Validate that the current subType is valid for the selected mainType
    final currentSubType = editState.formData?.subType;
    final validSubType = (currentSubType != null && availableSubTypes.contains(currentSubType)) 
        ? currentSubType 
        : null;
    
    return DropdownButtonFormField<SubType>(
      value: validSubType,
      decoration: const InputDecoration(
        labelText: 'Specific Type',
        hintText: 'Select specific document type',
        prefixIcon: Icon(Icons.subdirectory_arrow_right),
        border: OutlineInputBorder(),
      ),
      items: availableSubTypes.map((subType) {
        return DropdownMenuItem<SubType>(
          value: subType,
          child: Text(_getSubTypeDisplayName(subType)),
        );
      }).toList(),
      onChanged: (SubType? value) {
        editController.updateSubType(value);
      },
    );
  }

  String _getSubTypeDisplayName(SubType subType) {
    switch (subType) {
      case SubType.passport:
        return 'Passport';
      case SubType.nationalId:
        return 'National ID';
      case SubType.driversLicense:
        return 'Driver\'s License';
      case SubType.birthCertificate:
        return 'Birth Certificate';
      case SubType.carRegistration:
        return 'Car Registration';
      case SubType.carInsurance:
        return 'Car Insurance';
      case SubType.creditCard:
        return 'Credit Card';
      case SubType.bankStatement:
        return 'Bank Statement';
      case SubType.taxDocument:
        return 'Tax Document';
      case SubType.visa:
        return 'Visa';
      case SubType.boardingPass:
        return 'Boarding Pass';
      case SubType.hotelReservation:
        return 'Hotel Reservation';
      case SubType.genericDocument:
        return 'Generic Document';
    }
  }
}
