// lib/shared/theme/components/button_themes.dart

import 'package:flutter/material.dart';
import '../color_schemes.dart';

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    elevation: 2,
  ),
);

final filledButtonTheme = FilledButtonThemeData(
  style: FilledButton.styleFrom(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
);

final outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    foregroundColor: lightColorScheme.primary,
    side: BorderSide(color: lightColorScheme.outline),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
);

final textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    foregroundColor: lightColorScheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
);

final floatingActionButtonTheme = FloatingActionButtonThemeData(
  backgroundColor: lightColorScheme.primary,
  foregroundColor: lightColorScheme.onPrimary,
  elevation: 6,
  focusElevation: 8,
  hoverElevation: 8,
  highlightElevation: 12,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
);
