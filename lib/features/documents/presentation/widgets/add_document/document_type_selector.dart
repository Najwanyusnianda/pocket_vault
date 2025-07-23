import 'package:flutter/material.dart';
import '../../../../../core/database/models/document_type.dart';
import '../../helpers/document_type_helpers.dart';

class DocumentTypeSelector extends StatelessWidget {
  final MainType? selectedType;
  final ValueChanged<MainType?> onTypeSelected;

  const DocumentTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Document Type',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: MainType.values.map((type) {
            final isSelected = selectedType == type;
            return FilterChip(
              label: Text(type.getName()),
              avatar: Icon(type.getIcon(), size: 16),
              selected: isSelected,
              onSelected: (selected) {
                onTypeSelected(selected ? type : null);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
