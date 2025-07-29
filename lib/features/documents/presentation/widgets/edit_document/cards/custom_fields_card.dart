// lib/features/documents/presentation/widgets/edit_document/cards/custom_fields_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../../../../core/database/models/document_type.dart';
import '../../../controllers/edit_document_controller.dart';
import '../../../helpers/custom_fields_definitions.dart';
import '../form_fields/dynamic_custom_field.dart';

class CustomFieldsCard extends ConsumerWidget {
  final Document document;

  const CustomFieldsCard({
    super.key,
    required this.document,  
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final editState = ref.watch(editDocumentControllerProvider(document));
    
    final subType = editState.formData?.subType;
    
    // Only show if there's a subType and it has custom fields
    if (subType == null || !CustomFieldsDefinitions.hasCustomFields(subType)) {
      return const SizedBox.shrink();
    }
    
    final customFieldDefinitions = CustomFieldsDefinitions.getFieldsForSubType(subType);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header
            Row(
              children: [
                Icon(
                  Icons.tune,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  '${_getSubTypeDisplayName(subType)} Details',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Dynamic Custom Fields
            ...customFieldDefinitions.map((fieldDef) {
              return Column(
                children: [
                  DynamicCustomField(
                    document: document,
                    fieldDefinition: fieldDef,
                  ),
                  if (fieldDef != customFieldDefinitions.last)
                    const SizedBox(height: 16),
                ],
              );
            }),
          ],
        ),
      ),
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
