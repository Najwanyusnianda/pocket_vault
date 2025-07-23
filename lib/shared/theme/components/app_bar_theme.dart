// lib/shared/theme/components/app_bar_theme.dart

import 'package:flutter/material.dart';
import '../color_schemes.dart';

final appBarTheme = AppBarTheme(
  backgroundColor: lightColorScheme.surface,
  foregroundColor: lightColorScheme.onSurface,
  elevation: 0,
  centerTitle: true,
  titleTextStyle: const TextStyle(
    fontFamily: 'Nunito',
    fontSize: 20,
    fontWeight: FontWeight.w600,
  ),
  iconTheme: IconThemeData(
    color: lightColorScheme.onSurface,
    size: 24,
  ),
  actionsIconTheme: IconThemeData(
    color: lightColorScheme.onSurface,
    size: 24,
  ),
  surfaceTintColor: lightColorScheme.surfaceTint,
);
