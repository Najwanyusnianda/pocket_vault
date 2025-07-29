// lib/shared/theme/components/card_theme.dart

import 'package:flutter/material.dart';
import '../color_schemes.dart';

final cardTheme = CardThemeData(
  color: lightColorScheme.surface,
  surfaceTintColor: Colors.transparent,
  elevation: 0.5,
  shadowColor: lightColorScheme.shadow.withValues(alpha:0.1),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(
      color: lightColorScheme.outline.withValues(alpha:0.1),
      width: 0.5,
    ),
  ),
  clipBehavior: Clip.antiAlias,
  margin: EdgeInsets.zero, // We handle margins in the widget
);
