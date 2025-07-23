// lib/shared/theme/components/bottom_sheet_theme.dart

import 'package:flutter/material.dart';
import '../color_schemes.dart';

final bottomSheetTheme = BottomSheetThemeData(
  backgroundColor: lightColorScheme.surface,
  surfaceTintColor: lightColorScheme.surfaceTint,
  elevation: 8,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(24),
    ),
  ),
  clipBehavior: Clip.antiAlias,
  constraints: const BoxConstraints(
    minWidth: double.infinity,
  ),
);
