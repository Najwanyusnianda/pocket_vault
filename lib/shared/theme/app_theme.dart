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

  // Enhanced Component Themes
  appBarTheme: lightAppBarTheme, // Updated to use enhanced theme
  elevatedButtonTheme: lightElevatedButtonTheme, // Updated to use enhanced theme
  filledButtonTheme: lightFilledButtonTheme, // Updated to use enhanced theme
  outlinedButtonTheme: lightOutlinedButtonTheme, // Updated to use enhanced theme
  textButtonTheme: lightTextButtonTheme, // Updated to use enhanced theme
  floatingActionButtonTheme: lightFloatingActionButtonTheme, // Updated to use enhanced theme
  cardTheme: cardTheme,
  inputDecorationTheme: lightInputDecorationTheme, // Already updated
  listTileTheme: lightListTileTheme, // Updated to use enhanced theme
  bottomSheetTheme: lightBottomSheetTheme, // Updated to use enhanced theme
);

// Dark theme with enhanced dark color scheme
final ThemeData darkAppTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  textTheme: nunitoTextTheme,

  // Enhanced Dark Component Themes
  appBarTheme: darkAppBarTheme, // Updated to use enhanced dark theme
  elevatedButtonTheme: darkElevatedButtonTheme, // Updated to use enhanced dark theme
  filledButtonTheme: darkFilledButtonTheme, // Updated to use enhanced dark theme
  outlinedButtonTheme: darkOutlinedButtonTheme, // Updated to use enhanced dark theme
  textButtonTheme: darkTextButtonTheme, // Updated to use enhanced dark theme
  floatingActionButtonTheme: darkFloatingActionButtonTheme, // Updated to use enhanced dark theme
  cardTheme: cardTheme.copyWith(
    color: darkColorScheme.surface,
    surfaceTintColor: darkColorScheme.surfaceTint,
  ),
  inputDecorationTheme: darkInputDecorationTheme, // Already updated
  listTileTheme: darkListTileTheme, // Updated to use enhanced dark theme
  bottomSheetTheme: darkBottomSheetTheme, // Updated to use enhanced dark theme
);

// Riverpod providers for theme management
final themeDataProvider = Provider<ThemeData>((ref) => appTheme);
final darkThemeDataProvider = Provider<ThemeData>((ref) => darkAppTheme);

// Theme mode provider (for switching between light/dark)
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
