// lib/core/database/models/custom_field.dart
import 'dart:convert';

/// Represents a custom field definition for a specific document subtype
class CustomFieldDefinition {
  final String key;
  final String label;
  final CustomFieldType type;
  final bool isRequired;
  final String? hint;
  final List<String>? options; // For dropdown/select fields

  const CustomFieldDefinition({
    required this.key,
    required this.label,
    required this.type,
    this.isRequired = false,
    this.hint,
    this.options,
  });

  Map<String, dynamic> toJson() => {
    'key': key,
    'label': label,
    'type': type.name,
    'isRequired': isRequired,
    'hint': hint,
    'options': options,
  };

  factory CustomFieldDefinition.fromJson(Map<String, dynamic> json) => 
    CustomFieldDefinition(
      key: json['key'] as String,
      label: json['label'] as String,
      type: CustomFieldType.values.byName(json['type'] as String),
      isRequired: json['isRequired'] as bool? ?? false,
      hint: json['hint'] as String?,
      options: (json['options'] as List<dynamic>?)?.cast<String>(),
    );
}

/// Represents a custom field value instance
class CustomFieldValue {
  final String key;
  final dynamic value;
  final CustomFieldType type;

  const CustomFieldValue({
    required this.key,
    required this.value,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'key': key,
    'value': value,
    'type': type.name,
  };

  factory CustomFieldValue.fromJson(Map<String, dynamic> json) => 
    CustomFieldValue(
      key: json['key'] as String,
      value: json['value'],
      type: CustomFieldType.values.byName(json['type'] as String),
    );

  /// Get typed value based on field type
  T getValue<T>() {
    switch (type) {
      case CustomFieldType.text:
        return (value as String) as T;
      case CustomFieldType.number:
        return (value is String ? double.tryParse(value) ?? 0.0 : value as double) as T;
      case CustomFieldType.date:
        return (value is String ? DateTime.tryParse(value) : value as DateTime?) as T;
      case CustomFieldType.boolean:
        return (value is String ? value.toLowerCase() == 'true' : value as bool) as T;
      case CustomFieldType.select:
        return (value as String) as T;
    }
  }
}

/// Types of custom fields supported
enum CustomFieldType {
  text,
  number,
  date,
  boolean,
  select, // Dropdown with predefined options
}

/// Helper class for custom fields JSON operations
class CustomFieldsHelper {
  /// Parse JSON string to custom fields map
  static Map<String, CustomFieldValue> parseCustomFields(String? json) {
    if (json == null || json.isEmpty) return {};
    
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map((key, value) => MapEntry(
        key,
        CustomFieldValue.fromJson(value as Map<String, dynamic>),
      ));
    } catch (e) {
      return {};
    }
  }

  /// Encode custom fields map to JSON string
  static String encodeCustomFields(Map<String, CustomFieldValue> fields) {
    if (fields.isEmpty) return '';
    
    try {
      final encoded = fields.map((key, value) => MapEntry(key, value.toJson()));
      return jsonEncode(encoded);
    } catch (e) {
      return '';
    }
  }

  /// Get display value for a custom field
  static String getDisplayValue(CustomFieldValue field) {
    switch (field.type) {
      case CustomFieldType.text:
      case CustomFieldType.select:
        final value = field.getValue<String>();
        return value.isEmpty ? '' : value;
      case CustomFieldType.number:
        final num = field.getValue<double>();
        return num % 1 == 0 ? num.toInt().toString() : num.toString();
      case CustomFieldType.date:
        final date = field.getValue<DateTime?>();
        return date?.toString().split(' ')[0] ?? '';
      case CustomFieldType.boolean:
        return field.getValue<bool>() ? 'Yes' : 'No';
    }
  }
}
