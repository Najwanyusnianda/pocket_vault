// lib/shared/theme/components/button_themes.dart

import 'package:flutter/material.dart';
import '../color_schemes.dart';

/// Enhanced button themes with modern styling and better accessibility
/// Following Material 3 design principles with professional aesthetics

/// Primary Elevated Button - Main actions
ElevatedButtonThemeData createElevatedButtonTheme(ColorScheme colorScheme) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      // Modern color scheme
      backgroundColor: WidgetStateProperty.all(colorScheme.primary),
      foregroundColor: WidgetStateProperty.all(colorScheme.onPrimary),
      
      // Enhanced shape with increased border radius
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Increased from 12
        ),
      ),
      
      // Better touch targets - minimum 48px height
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      minimumSize: WidgetStateProperty.all(const Size(88, 48)),
      
      // Enhanced typography
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      
      // Interactive states
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return colorScheme.onPrimary.withOpacity(0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return colorScheme.onPrimary.withOpacity(0.12);
        }
        if (states.contains(WidgetState.pressed)) {
          return colorScheme.onPrimary.withOpacity(0.16);
        }
        return null;
      }),
      
      // Enhanced elevation states
      elevation: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return 0.0;
        if (states.contains(WidgetState.hovered)) return 4.0;
        if (states.contains(WidgetState.focused)) return 4.0;
        if (states.contains(WidgetState.pressed)) return 8.0;
        return 2.0;
      }),
      
      shadowColor: WidgetStateProperty.all(colorScheme.shadow.withOpacity(0.3)),
    ),
  );
}

/// Filled Button - Secondary actions
FilledButtonThemeData createFilledButtonTheme(ColorScheme colorScheme) {
  return FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(colorScheme.secondaryContainer),
      foregroundColor: WidgetStateProperty.all(colorScheme.onSecondaryContainer),
      
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      minimumSize: WidgetStateProperty.all(const Size(88, 48)),
      
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return colorScheme.onSecondaryContainer.withOpacity(0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return colorScheme.onSecondaryContainer.withOpacity(0.12);
        }
        if (states.contains(WidgetState.pressed)) {
          return colorScheme.onSecondaryContainer.withOpacity(0.16);
        }
        return null;
      }),
    ),
  );
}

/// Outlined Button - Tertiary actions
OutlinedButtonThemeData createOutlinedButtonTheme(ColorScheme colorScheme) {
  return OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(colorScheme.primary),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      side: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: colorScheme.primary, width: 2);
        }
        if (states.contains(WidgetState.hovered)) {
          return BorderSide(color: colorScheme.primary, width: 1.5);
        }
        return BorderSide(color: colorScheme.outline, width: 1);
      }),
      
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      minimumSize: WidgetStateProperty.all(const Size(88, 48)),
      
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return colorScheme.primary.withOpacity(0.04);
        }
        if (states.contains(WidgetState.focused)) {
          return colorScheme.primary.withOpacity(0.08);
        }
        if (states.contains(WidgetState.pressed)) {
          return colorScheme.primary.withOpacity(0.12);
        }
        return null;
      }),
    ),
  );
}

/// Text Button - Minimal actions
TextButtonThemeData createTextButtonTheme(ColorScheme colorScheme) {
  return TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(colorScheme.primary),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Slightly smaller for text buttons
        ),
      ),
      
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      minimumSize: WidgetStateProperty.all(const Size(64, 40)), // Smaller minimum for text buttons
      
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
      
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return colorScheme.primary.withOpacity(0.04);
        }
        if (states.contains(WidgetState.focused)) {
          return colorScheme.primary.withOpacity(0.08);
        }
        if (states.contains(WidgetState.pressed)) {
          return colorScheme.primary.withOpacity(0.12);
        }
        return null;
      }),
    ),
  );
}

/// Floating Action Button - Primary floating actions
FloatingActionButtonThemeData createFloatingActionButtonTheme(ColorScheme colorScheme) {
  return FloatingActionButtonThemeData(
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
    
    // Modern elevation system
    elevation: 6,
    focusElevation: 8,
    hoverElevation: 8,
    highlightElevation: 12,
    disabledElevation: 0,
    
    // Enhanced shape
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // More rounded for FAB
    ),
    
    // Professional sizing
    sizeConstraints: const BoxConstraints.tightFor(
      width: 56,
      height: 56,
    ),
    
    // Enhanced shadow
    splashColor: colorScheme.onPrimary.withOpacity(0.16),
    focusColor: colorScheme.onPrimary.withOpacity(0.12),
    hoverColor: colorScheme.onPrimary.withOpacity(0.08),
  );
}

// Create themes for both light and dark modes
final lightElevatedButtonTheme = createElevatedButtonTheme(lightColorScheme);
final darkElevatedButtonTheme = createElevatedButtonTheme(darkColorScheme);

final lightFilledButtonTheme = createFilledButtonTheme(lightColorScheme);
final darkFilledButtonTheme = createFilledButtonTheme(darkColorScheme);

final lightOutlinedButtonTheme = createOutlinedButtonTheme(lightColorScheme);
final darkOutlinedButtonTheme = createOutlinedButtonTheme(darkColorScheme);

final lightTextButtonTheme = createTextButtonTheme(lightColorScheme);
final darkTextButtonTheme = createTextButtonTheme(darkColorScheme);

final lightFloatingActionButtonTheme = createFloatingActionButtonTheme(lightColorScheme);
final darkFloatingActionButtonTheme = createFloatingActionButtonTheme(darkColorScheme);

// Legacy themes for backward compatibility
final elevatedButtonTheme = lightElevatedButtonTheme;
final filledButtonTheme = lightFilledButtonTheme;
final outlinedButtonTheme = lightOutlinedButtonTheme;
final textButtonTheme = lightTextButtonTheme;
final floatingActionButtonTheme = lightFloatingActionButtonTheme;
