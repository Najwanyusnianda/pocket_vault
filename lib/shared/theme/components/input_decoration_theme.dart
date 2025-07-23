// lib/shared/theme/components/input_decoration_theme.dart

import 'package:flutter/material.dart';
import '../color_schemes.dart';

final inputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: lightColorScheme.outline),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: lightColorScheme.outline),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: lightColorScheme.primary, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: lightColorScheme.error),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: lightColorScheme.error, width: 2),
  ),
  filled: true,
  fillColor: lightColorScheme.surface,
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  labelStyle: TextStyle(
    fontFamily: 'Nunito',
    color: lightColorScheme.onSurface,
  ),
  hintStyle: TextStyle(
    fontFamily: 'Nunito',
    color: lightColorScheme.onSurface.withOpacity(0.6),
  ),
  errorStyle: TextStyle(
    fontFamily: 'Nunito',
    color: lightColorScheme.error,
  ),
);
