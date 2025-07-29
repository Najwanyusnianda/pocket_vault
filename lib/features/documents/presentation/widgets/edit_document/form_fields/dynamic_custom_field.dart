// lib/features/documents/presentation/widgets/edit_document/form_fields/dynamic_custom_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/database/app_database.dart';
import '../../../../../../core/database/models/custom_field.dart';
import '../../../controllers/edit_document_controller.dart';

class DynamicCustomField extends ConsumerStatefulWidget {
  final Document document;
  final CustomFieldDefinition fieldDefinition;

  const DynamicCustomField({
    super.key,
    required this.document,
    required this.fieldDefinition,
  });

  @override
  ConsumerState<DynamicCustomField> createState() => _DynamicCustomFieldState();
}

class _DynamicCustomFieldState extends ConsumerState<DynamicCustomField> {
  late TextEditingController _textController;
  bool _boolValue = false;
  DateTime? _dateValue;

  @override
  void initState() {
    super.initState();
    _initializeFieldValue();
  }

  void _initializeFieldValue() {
    final editState = ref.read(editDocumentControllerProvider(widget.document));
    final customFields = editState.formData?.customFields ?? {};
    final currentValue = customFields[widget.fieldDefinition.key];

    switch (widget.fieldDefinition.type) {
      case CustomFieldType.text:
      case CustomFieldType.select:
        _textController = TextEditingController(
          text: currentValue?.toString() ?? '',
        );
        break;
      case CustomFieldType.number:
        _textController = TextEditingController(
          text: currentValue?.toString() ?? '',
        );
        break;
      case CustomFieldType.boolean:
        _boolValue = currentValue is bool ? currentValue : false;
        _textController = TextEditingController();
        break;
      case CustomFieldType.date:
        if (currentValue is String && currentValue.isNotEmpty) {
          _dateValue = DateTime.tryParse(currentValue);
        }
        _textController = TextEditingController(
          text: _dateValue != null 
              ? '${_dateValue!.day}/${_dateValue!.month}/${_dateValue!.year}'
              : '',
        );
        break;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editController = ref.read(editDocumentControllerProvider(widget.document).notifier);

    switch (widget.fieldDefinition.type) {
      case CustomFieldType.text:
        return _buildTextField(editController);
      case CustomFieldType.number:
        return _buildNumberField(editController);
      case CustomFieldType.date:
        return _buildDateField(editController);
      case CustomFieldType.boolean:
        return _buildBooleanField(editController);
      case CustomFieldType.select:
        return _buildSelectField(editController);
    }
  }

  Widget _buildTextField(dynamic editController) {
    return TextFormField(
      controller: _textController,
      decoration: InputDecoration(
        labelText: widget.fieldDefinition.label,
        hintText: widget.fieldDefinition.hint,
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        editController.updateCustomField(widget.fieldDefinition.key, value);
      },
    );
  }

  Widget _buildNumberField(dynamic editController) {
    return TextFormField(
      controller: _textController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: widget.fieldDefinition.label,
        hintText: widget.fieldDefinition.hint,
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        final numValue = double.tryParse(value) ?? 0.0;
        editController.updateCustomField(widget.fieldDefinition.key, numValue);
      },
    );
  }

  Widget _buildDateField(dynamic editController) {
    return TextFormField(
      controller: _textController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.fieldDefinition.label,
        hintText: widget.fieldDefinition.hint ?? 'Select date',
        prefixIcon: const Icon(Icons.calendar_today),
        suffixIcon: _dateValue != null
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _dateValue = null;
                    _textController.clear();
                  });
                  editController.updateCustomField(widget.fieldDefinition.key, null);
                },
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: _dateValue ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        
        if (selectedDate != null) {
          setState(() {
            _dateValue = selectedDate;
            _textController.text = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
          });
          editController.updateCustomField(
            widget.fieldDefinition.key, 
            selectedDate.toIso8601String(),
          );
        }
      },
    );
  }

  Widget _buildBooleanField(dynamic editController) {
    return ListTile(
      title: Text(widget.fieldDefinition.label),
      subtitle: widget.fieldDefinition.hint != null 
          ? Text(widget.fieldDefinition.hint!)
          : null,
      trailing: Switch(
        value: _boolValue,
        onChanged: (value) {
          setState(() {
            _boolValue = value;
          });
          editController.updateCustomField(widget.fieldDefinition.key, value);
        },
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSelectField(dynamic editController) {
    final options = widget.fieldDefinition.options ?? [];
    final currentValue = _textController.text.isEmpty ? null : _textController.text;
    
    return DropdownButtonFormField<String>(
      value: options.contains(currentValue) ? currentValue : null,
      decoration: InputDecoration(
        labelText: widget.fieldDefinition.label,
        hintText: widget.fieldDefinition.hint ?? 'Select option',
        border: const OutlineInputBorder(),
      ),
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _textController.text = value ?? '';
        });
        editController.updateCustomField(widget.fieldDefinition.key, value);
      },
    );
  }
}
