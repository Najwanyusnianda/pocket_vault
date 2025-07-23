// lib/shared/theme/components/list_tile_theme.dart

import 'package:flutter/material.dart';
import '../color_schemes.dart';

final listTileTheme = ListTileThemeData(
  tileColor: lightColorScheme.surface,
  selectedTileColor: lightColorScheme.primaryContainer,
  selectedColor: lightColorScheme.onPrimaryContainer,
  textColor: lightColorScheme.onSurface,
  iconColor: lightColorScheme.primary,
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  titleTextStyle: const TextStyle(
    fontFamily: 'Nunito',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  subtitleTextStyle: const TextStyle(
    fontFamily: 'Nunito',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
);
