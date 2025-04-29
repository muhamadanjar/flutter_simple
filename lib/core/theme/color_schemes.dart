import 'package:flutter/material.dart';

class AppColorScheme {
  // Prevent instantiation
  AppColorScheme._();

  // Main brand colors
  static const Color primaryColor = Color(0xFF3F51B5); // Indigo
  static const Color secondaryColor = Color(0xFFFF4081); // Pink accent
  static const Color tertiaryColor = Color(0xFF009688); // Teal

  // Light color scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFE8EAF6),
    onPrimaryContainer: Color(0xFF1A237E),
    secondary: secondaryColor,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFFCE4EC),
    onSecondaryContainer: Color(0xFFC2185B),
    tertiary: tertiaryColor,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFE0F2F1),
    onTertiaryContainer: Color(0xFF004D40),
    error: Color(0xFFB00020),
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD5),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFF5F5F5),
    onBackground: Color(0xFF1C1B1F),
    surface: Colors.white,
    onSurface: Color(0xFF1C1B1F),
    surfaceVariant: Color(0xFFE7E0EC),
    onSurfaceVariant: Color(0xFF49454F),
    outline: Color(0xFF79747E),
    outlineVariant: Color(0xFFCAC4D0),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF313033),
    onInverseSurface: Color(0xFFF4EFF4),
    inversePrimary: Color(0xFFB5C0FF),
    surfaceTint: primaryColor,
  );

  // Dark color scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF8C9EFF), // Lighter Indigo
    onPrimary: Color(0xFF1A237E),
    primaryContainer: Color(0xFF303F9F),
    onPrimaryContainer: Color(0xFFE8EAF6),
    secondary: Color(0xFFFF80AB), // Lighter Pink
    onSecondary: Color(0xFFC2185B),
    secondaryContainer: Color(0xFFD81B60),
    onSecondaryContainer: Color(0xFFFCE4EC),
    tertiary: Color(0xFF80CBC4), // Lighter Teal
    onTertiary: Color(0xFF004D40),
    tertiaryContainer: Color(0xFF00796B),
    onTertiaryContainer: Color(0xFFE0F2F1),
    error: Color(0xFFCF6679),
    onError: Color(0xFF410002),
    errorContainer: Color(0xFF8B1D1D),
    onErrorContainer: Color(0xFFFFDAD5),
    background: Color(0xFF121212),
    onBackground: Color(0xFFE6E1E5),
    surface: Color(0xFF1E1E1E),
    onSurface: Color(0xFFE6E1E5),
    surfaceVariant: Color(0xFF49454F),
    onSurfaceVariant: Color(0xFFCAC4D0),
    outline: Color(0xFF938F99),
    outlineVariant: Color(0xFF49454F),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFFFFBFE),
    onInverseSurface: Color(0xFF1C1B1F),
    inversePrimary: primaryColor,
    surfaceTint: Color(0xFF8C9EFF),
  );
}