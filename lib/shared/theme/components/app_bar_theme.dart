// lib/shared/theme/components/app_bar_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../color_schemes.dart';

/// Enhanced AppBar theme with modern styling and better visual hierarchy
AppBarTheme createAppBarTheme(ColorScheme colorScheme, {bool isDark = false}) {
  return AppBarTheme(
    // Modern glass-morphism effect
    backgroundColor: colorScheme.surface.withOpacity(0.95),
    foregroundColor: colorScheme.onSurface,
    surfaceTintColor: colorScheme.surfaceTint.withOpacity(0.1),
    
    // Subtle elevation for depth
    elevation: 0,
    scrolledUnderElevation: 2,
    shadowColor: colorScheme.shadow.withOpacity(0.1),
    
    // Professional centered layout
    centerTitle: true,
    
    // Enhanced typography with better hierarchy
    titleTextStyle: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 20,
      fontWeight: FontWeight.w700, // Bolder for better hierarchy
      color: colorScheme.onSurface,
      letterSpacing: 0.5,
      height: 1.2,
    ),
    
    // Refined icon styling
    iconTheme: IconThemeData(
      color: colorScheme.onSurface.withOpacity(0.8),
      size: 24,
      weight: 500, // Modern icon weight
    ),
    
    actionsIconTheme: IconThemeData(
      color: colorScheme.primary,
      size: 24,
      weight: 500,
    ),
    
    // Enhanced system UI overlay
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: colorScheme.surface,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ),
    
    // Professional toolbar height
    toolbarHeight: 64,
    
    // Better shape definition
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(0), // Clean modern look
      ),
    ),
  );
}

// Create themes for both light and dark modes
final lightAppBarTheme = createAppBarTheme(lightColorScheme, isDark: false);
final darkAppBarTheme = createAppBarTheme(darkColorScheme, isDark: true);

// Legacy theme for backward compatibility
final appBarTheme = lightAppBarTheme;
