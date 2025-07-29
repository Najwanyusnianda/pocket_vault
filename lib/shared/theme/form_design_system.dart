// lib/shared/theme/form_design_system.dart

import 'package:flutter/material.dart';

/// Design system for consistent form styling across the app
class FormDesignSystem {
  // ✅ Section color coding for visual hierarchy
  static const Map<FormSection, Color> sectionColors = {
    FormSection.mainDetails: Color(0xFF2196F3),    // Blue for main details
    FormSection.attributes: Color(0xFF4CAF50),     // Green for attributes  
    FormSection.customFields: Color(0xFF9C27B0),   // Purple for dynamic fields
    FormSection.actions: Color(0xFFFF9800),        // Orange for actions
    FormSection.information: Color(0xFF607D8B),    // Blue-gray for read-only
  };
  
  // ✅ Typography scale for better visual hierarchy
  static TextStyle sectionHeaderStyle(BuildContext context, FormSection section) {
    return TextStyle(
      fontFamily: 'Nunito',
      fontSize: 20,
      fontWeight: FontWeight.w700, // Bold section headers
      color: sectionColors[section],
      letterSpacing: 0.5,
      height: 1.2,
    );
  }
  
  static TextStyle subsectionHeaderStyle(BuildContext context, FormSection section) {
    return TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16,
      fontWeight: FontWeight.w600, // Medium weight for subsections
      color: sectionColors[section]!.withOpacity(0.8),
      letterSpacing: 0.3,
      height: 1.3,
    );
  }
  
  static TextStyle fieldLabelStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14,  // Smaller field labels
      fontWeight: FontWeight.w500,
      color: theme.colorScheme.onSurface.withOpacity(0.8),
      letterSpacing: 0.1,
    );
  }
  
  static TextStyle inputTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16,  // Larger input text
      fontWeight: FontWeight.w400,
      color: theme.colorScheme.onSurface,
      letterSpacing: 0.2,
    );
  }
  
  static TextStyle helperTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(
      fontFamily: 'Nunito',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: theme.colorScheme.onSurface.withOpacity(0.6),
      letterSpacing: 0.1,
    );
  }
  
  // ✅ Card styling for sections with subtle elevation
  static BoxDecoration sectionCardDecoration(
    BuildContext context, 
    FormSection section,
    {bool isElevated = true, bool isActive = false}
  ) {
    final theme = Theme.of(context);
    final sectionColor = sectionColors[section]!;
    
    return BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isActive 
          ? sectionColor.withOpacity(0.4)
          : sectionColor.withOpacity(0.2),
        width: isActive ? 1.5 : 1,
      ),
      boxShadow: isElevated ? [
        BoxShadow(
          color: theme.colorScheme.shadow.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: sectionColor.withOpacity(0.04),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ] : null,
    );
  }
  
  // ✅ Interactive input decoration with micro-interactions
  static InputDecoration enhancedInputDecoration({
    required String labelText,
    required IconData prefixIcon,
    String? hintText,
    String? helperText,
    FormSection section = FormSection.mainDetails,
    bool hasError = false,
    bool isFocused = false,
    Widget? suffixIcon,
  }) {
    final sectionColor = sectionColors[section]!;
    
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      prefixIcon: Icon(
        prefixIcon,
        color: isFocused 
          ? sectionColor 
          : sectionColor.withOpacity(0.6),
        size: 22,
      ),
      suffixIcon: suffixIcon,
      
      // Enhanced border with section color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: sectionColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: sectionColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: sectionColor,
          width: 2.5,
        ),
      ),
      
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Colors.red.withOpacity(0.8),
          width: 1.5,
        ),
      ),
      
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.5,
        ),
      ),
      
      // Animated fill color
      filled: true,
      fillColor: isFocused 
        ? sectionColor.withOpacity(0.04)
        : Colors.transparent,
      
      // Enhanced content padding for better touch targets
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      
      // Consistent constraints
      constraints: const BoxConstraints(
        minHeight: 56,
      ),
    );
  }
  
  // ✅ Section icon styling
  static Widget sectionIcon(FormSection section, {double size = 24}) {
    final sectionColor = sectionColors[section]!;
    IconData iconData;
    
    switch (section) {
      case FormSection.mainDetails:
        iconData = Icons.edit_document;
        break;
      case FormSection.attributes:
        iconData = Icons.category;
        break;
      case FormSection.customFields:
        iconData = Icons.tune;
        break;
      case FormSection.actions:
        iconData = Icons.settings;
        break;
      case FormSection.information:
        iconData = Icons.info_outline;
        break;
    }
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: sectionColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        iconData,
        color: sectionColor,
        size: size,
      ),
    );
  }
  
  // ✅ Spacing constants for consistent layout
  static const double sectionSpacing = 24.0;
  static const double fieldSpacing = 20.0;
  static const double cardPadding = 24.0;
  static const double borderRadius = 20.0;
  
  // ✅ Animation durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
}

/// Enum for different form sections
enum FormSection {
  mainDetails,
  attributes, 
  customFields,
  actions,
  information,
}
