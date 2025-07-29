// lib/shared/theme/components/list_tile_theme.dart

import 'package:flutter/material.dart';
import '../color_schemes.dart';

/// Enhanced list tile theme with modern styling and better visual hierarchy
/// Following Material 3 design principles with professional aesthetics

/// Create enhanced list tile theme with interactive states
ListTileThemeData createListTileTheme(ColorScheme colorScheme) {
  return ListTileThemeData(
    // Modern surface colors with subtle contrast
    tileColor: colorScheme.surface,
    selectedTileColor: colorScheme.primaryContainer.withOpacity(0.12),
    selectedColor: colorScheme.primary,
    
    // Enhanced text colors for better readability
    textColor: colorScheme.onSurface,
    iconColor: colorScheme.onSurfaceVariant.withOpacity(0.8),
    
    // Professional spacing with better touch targets
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20, // Increased from 16 for better spacing
      vertical: 12,   // Increased from 8 for better touch targets
    ),
    
    // Modern rounded corners matching our design system
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), // Increased from 8 to match form fields
    ),
    
    // Enhanced typography hierarchy
    titleTextStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16,
      fontWeight: FontWeight.w600, // Medium weight for better hierarchy
      color: colorScheme.onSurface,
      letterSpacing: 0.1,
      height: 1.3,
    ),
    
    subtitleTextStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSurfaceVariant,
      letterSpacing: 0.1,
      height: 1.4,
    ),
    
    leadingAndTrailingTextStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: colorScheme.onSurfaceVariant,
      letterSpacing: 0.2,
    ),
    
    // Enhanced density for better visual balance
    dense: false,
    
    // Professional minimum height
    minVerticalPadding: 12,
    
    // Enhanced visual density
    visualDensity: VisualDensity.comfortable,
    
    // Enhanced mouse cursor
    mouseCursor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return SystemMouseCursors.basic;
      }
      return SystemMouseCursors.click;
    }),
  );
}

/// Enhanced navigation list tile theme for drawer/navigation
ListTileThemeData createNavigationListTileTheme(ColorScheme colorScheme) {
  return ListTileThemeData(
    // Navigation-specific styling
    tileColor: Colors.transparent,
    selectedTileColor: colorScheme.primaryContainer.withOpacity(0.15),
    selectedColor: colorScheme.primary,
    
    textColor: colorScheme.onSurface,
    iconColor: colorScheme.primary.withOpacity(0.8),
    
    // Enhanced padding for navigation
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 24, // More padding for navigation
      vertical: 16,   // Better touch targets for navigation
    ),
    
    // Rounded shape for modern navigation
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // More rounded for navigation
    ),
    
    // Navigation-specific typography
    titleTextStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: colorScheme.onSurface,
      letterSpacing: 0.2,
    ),
    
    subtitleTextStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSurfaceVariant,
      letterSpacing: 0.1,
    ),
    
    minVerticalPadding: 16,
    visualDensity: VisualDensity.comfortable,
    
    mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
  );
}

/// Enhanced settings list tile theme
ListTileThemeData createSettingsListTileTheme(ColorScheme colorScheme) {
  return ListTileThemeData(
    // Settings-specific styling
    tileColor: colorScheme.surface,
    selectedTileColor: colorScheme.surfaceContainerHighest,
    selectedColor: colorScheme.onSurface,
    
    textColor: colorScheme.onSurface,
    iconColor: colorScheme.onSurfaceVariant,
    
    // Professional settings spacing
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 14,
    ),
    
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Subtle rounding for settings
    ),
    
    // Settings typography
    titleTextStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16,
      fontWeight: FontWeight.w500, // Slightly lighter for settings
      color: colorScheme.onSurface,
      letterSpacing: 0.1,
    ),
    
    subtitleTextStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSurfaceVariant,
      letterSpacing: 0.05,
    ),
    
    minVerticalPadding: 14,
    visualDensity: VisualDensity.standard,
    
    mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
  );
}

// Create themes for both light and dark modes
final lightListTileTheme = createListTileTheme(lightColorScheme);
final darkListTileTheme = createListTileTheme(darkColorScheme);

final lightNavigationListTileTheme = createNavigationListTileTheme(lightColorScheme);
final darkNavigationListTileTheme = createNavigationListTileTheme(darkColorScheme);

final lightSettingsListTileTheme = createSettingsListTileTheme(lightColorScheme);
final darkSettingsListTileTheme = createSettingsListTileTheme(darkColorScheme);

// Legacy theme for backward compatibility
final listTileTheme = lightListTileTheme;
