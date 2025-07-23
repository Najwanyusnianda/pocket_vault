// lib/shared/theme/color_schemes.dart

import 'package:flutter/material.dart';

const Color seedColor = Colors.blueGrey; // "The Modern Fortress" base color

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: seedColor,
  brightness: Brightness.light,
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: seedColor,
  brightness: Brightness.dark,
);
