// lib/features/documents/presentation/widgets/add_document/expiration_date_picker.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpirationDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateSelected;

  const ExpirationDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 20)),
    );
    onDateSelected(date);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Expiration Date (Optional)',
          suffixIcon: Icon(Icons.calendar_today),
        ),
        child: Text(
          selectedDate != null
              ? DateFormat.yMMMd().format(selectedDate!)
              : 'Not set',
        ),
      ),
    );
  }
}
