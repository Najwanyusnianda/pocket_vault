// lib/shared/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'color_schemes.dart';
import 'text_styles.dart';
import 'components/app_bar_theme.dart';
import 'components/button_themes.dart';
import 'components/card_theme.dart';
import 'components/input_decoration_theme.dart';
import 'components/list_tile_theme.dart';
import 'components/bottom_sheet_theme.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: nunitoTextTheme,

  // Component Themes
  appBarTheme: appBarTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  filledButtonTheme: filledButtonTheme,
  outlinedButtonTheme: outlinedButtonTheme,
  textButtonTheme: textButtonTheme,
  floatingActionButtonTheme: floatingActionButtonTheme,
  cardTheme: cardTheme,
  inputDecorationTheme: inputDecorationTheme,
  listTileTheme: listTileTheme,
  bottomSheetTheme: bottomSheetTheme,
);

// Dark theme with dark color scheme
final ThemeData darkAppTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: nunitoTextTheme,

  // Component Themes (you can create dark variants if needed)
  appBarTheme: appBarTheme.copyWith(
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    iconTheme: IconThemeData(color: darkColorScheme.onSurface),
    actionsIconTheme: IconThemeData(color: darkColorScheme.onSurface),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: elevatedButtonTheme.style?.copyWith(
      backgroundColor: WidgetStateProperty.all(darkColorScheme.primary),
      foregroundColor: WidgetStateProperty.all(darkColorScheme.onPrimary),
    ),
  ),
  cardTheme: cardTheme.copyWith(
    color: darkColorScheme.surface,
    surfaceTintColor: darkColorScheme.surfaceTint,
  ),
  inputDecorationTheme: inputDecorationTheme.copyWith(
    fillColor: darkColorScheme.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: darkColorScheme.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: darkColorScheme.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
    ),
  ),
  listTileTheme: listTileTheme.copyWith(
    tileColor: darkColorScheme.surface,
    selectedTileColor: darkColorScheme.primaryContainer,
    selectedColor: darkColorScheme.onPrimaryContainer,
    textColor: darkColorScheme.onSurface,
    iconColor: darkColorScheme.primary,
  ),
  bottomSheetTheme: bottomSheetTheme.copyWith(
    backgroundColor: darkColorScheme.surface,
    surfaceTintColor: darkColorScheme.surfaceTint,
  ),
);

// Riverpod providers for theme management
final themeDataProvider = Provider<ThemeData>((ref) => appTheme);
final darkThemeDataProvider = Provider<ThemeData>((ref) => darkAppTheme);

// Theme mode provider (for switching between light/dark)
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
