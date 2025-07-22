import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// Create a provider for your theme
final appThemeProvider = Provider<ThemeData>((ref) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey, // Choose a base color for your app
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.interTextTheme(), // Use a clean, modern font
    useMaterial3: true,
  );
});
