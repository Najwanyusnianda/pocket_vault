// lib/shared/theme/components/bottom_sheet_theme.dart

import 'package:flutter/material.dart';
import '../color_schemes.dart';

/// Enhanced bottom sheet theme with modern styling and better UX
BottomSheetThemeData createBottomSheetTheme(ColorScheme colorScheme) {
  return BottomSheetThemeData(
    // Modern glass-morphism background
    backgroundColor: colorScheme.surface,
    surfaceTintColor: colorScheme.surfaceTint.withOpacity(0.05),
    
    // Professional elevation with subtle shadow
    elevation: 12,
    shadowColor: colorScheme.shadow.withOpacity(0.15),
    
    // Enhanced shape with modern rounded corners
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(28), // Increased from 24 for more modern look
      ),
    ),
    
    // Smooth clipping for better performance
    clipBehavior: Clip.antiAlias,
    
    // Professional constraints
    constraints: const BoxConstraints(
      minWidth: double.infinity,
      maxHeight: 0.9 * 800, // 90% of typical screen height
    ),
    
    // Enhanced modal properties
    modalBackgroundColor: colorScheme.surface,
    modalElevation: 16,
    
    // Drag handle styling for better UX
    dragHandleColor: colorScheme.onSurfaceVariant.withOpacity(0.4),
    dragHandleSize: const Size(40, 4),
  );
}

/// Enhanced modal bottom sheet theme
BottomSheetThemeData createModalBottomSheetTheme(ColorScheme colorScheme) {
  return BottomSheetThemeData(
    // Modal-specific styling
    backgroundColor: Colors.transparent, // Allow custom background
    surfaceTintColor: Colors.transparent,
    
    // Higher elevation for modals
    elevation: 24,
    shadowColor: colorScheme.shadow.withOpacity(0.2),
    
    // More rounded for modal presentation
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32),
      ),
    ),
    
    clipBehavior: Clip.antiAlias,
    
    // Full-featured modal constraints
    constraints: const BoxConstraints(
      minWidth: double.infinity,
      maxHeight: double.infinity,
    ),
    
    // Modal-specific properties
    modalBackgroundColor: colorScheme.surface,
    modalElevation: 24,
    
    // Enhanced drag handle for modals
    dragHandleColor: colorScheme.primary.withOpacity(0.6),
    dragHandleSize: const Size(48, 5),
  );
}

// Create themes for both light and dark modes
final lightBottomSheetTheme = createBottomSheetTheme(lightColorScheme);
final darkBottomSheetTheme = createBottomSheetTheme(darkColorScheme);

final lightModalBottomSheetTheme = createModalBottomSheetTheme(lightColorScheme);
final darkModalBottomSheetTheme = createModalBottomSheetTheme(darkColorScheme);

// Legacy theme for backward compatibility
final bottomSheetTheme = lightBottomSheetTheme;
