// lib/shared/theme/components/input_decoration_theme.dart

import 'package:flutter/material.dart';
import '../color_schemes.dart';

// Enhanced input decoration theme with better visual hierarchy
InputDecorationTheme createInputDecorationTheme(ColorScheme colorScheme) {
  return InputDecorationTheme(
    // Modern outlined border with increased radius
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16), // Increased from 12
      borderSide: BorderSide(
        color: colorScheme.outline.withOpacity(0.5), // Subtle border
        width: 1,
      ),
    ),
    
    // Enhanced enabled state with subtle styling
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: colorScheme.outline.withOpacity(0.3), // Very subtle when not focused
        width: 1,
      ),
    ),
    
    // Strong focus state for better accessibility
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: colorScheme.primary, 
        width: 2.5, // Increased thickness for better focus indication
      ),
    ),
    
    // Clear error indication
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: colorScheme.error.withOpacity(0.8),
        width: 1.5,
      ),
    ),
    
    // Strong error focus
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: colorScheme.error,
        width: 2.5,
      ),
    ),
    
    // Modern filled style with elevation
    filled: true,
    fillColor: colorScheme.surface.withOpacity(0.8),
    
    // Improved touch targets - 44px minimum height
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20, // Increased padding
      vertical: 16,   // Ensures 44px touch target
    ),
    
    // Enhanced typography hierarchy
    labelStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14,
      fontWeight: FontWeight.w500, // Medium weight for labels
      color: colorScheme.onSurface.withOpacity(0.7),
      letterSpacing: 0.1,
    ),
    
    // Floating label style
    floatingLabelStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 12,
      fontWeight: FontWeight.w600, // Bolder for floating labels
      color: colorScheme.primary,
      letterSpacing: 0.5,
    ),
    
    // Subtle hint text
    hintStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSurface.withOpacity(0.4),
      letterSpacing: 0.1,
    ),
    
    // Clear error styling
    errorStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: colorScheme.error,
      letterSpacing: 0.1,
    ),
    
    // Enhanced prefix/suffix icon styling
    prefixIconColor: colorScheme.onSurface.withOpacity(0.6),
    suffixIconColor: colorScheme.onSurface.withOpacity(0.6),
    
    // Constraints for consistent sizing
    constraints: const BoxConstraints(
      minHeight: 56, // Ensures good touch target
    ),
  );
}

// Create themes for both light and dark modes
final lightInputDecorationTheme = createInputDecorationTheme(lightColorScheme);
final darkInputDecorationTheme = createInputDecorationTheme(darkColorScheme);
