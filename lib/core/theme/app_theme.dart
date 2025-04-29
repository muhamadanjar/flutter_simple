import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'text_themes.dart';

class AppTheme {
  // Prevent instantiation
  AppTheme._();

  // Light theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.lightColorScheme,
    textTheme: AppTextTheme.textTheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColorScheme.lightColorScheme.primary,
      foregroundColor: AppColorScheme.lightColorScheme.onPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColorScheme.lightColorScheme.onPrimary,
        backgroundColor: AppColorScheme.lightColorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    cardTheme: CardTheme(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorScheme.lightColorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorScheme.lightColorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorScheme.lightColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorScheme.lightColorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorScheme.lightColorScheme.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColorScheme.lightColorScheme.primary,
      foregroundColor: AppColorScheme.lightColorScheme.onPrimary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorScheme.lightColorScheme.surface,
      selectedItemColor: AppColorScheme.lightColorScheme.primary,
      unselectedItemColor: AppColorScheme.lightColorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
    ),
    dividerTheme: DividerThemeData(
      color: AppColorScheme.lightColorScheme.outlineVariant,
      thickness: 1,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColorScheme.lightColorScheme.surfaceVariant,
      labelStyle: AppTextTheme.textTheme.labelMedium?.copyWith(
        color: AppColorScheme.lightColorScheme.onSurfaceVariant,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );

  // Dark theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.darkColorScheme,
    textTheme: AppTextTheme.textTheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColorScheme.darkColorScheme.primary,
      foregroundColor: AppColorScheme.darkColorScheme.onPrimary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColorScheme.darkColorScheme.onPrimary,
        backgroundColor: AppColorScheme.darkColorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    cardTheme: CardTheme(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorScheme.darkColorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorScheme.darkColorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorScheme.darkColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorScheme.darkColorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColorScheme.darkColorScheme.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColorScheme.darkColorScheme.primary,
      foregroundColor: AppColorScheme.darkColorScheme.onPrimary,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorScheme.darkColorScheme.surface,
      selectedItemColor: AppColorScheme.darkColorScheme.primary,
      unselectedItemColor: AppColorScheme.darkColorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
    ),
    dividerTheme: DividerThemeData(
      color: AppColorScheme.darkColorScheme.outlineVariant,
      thickness: 1,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColorScheme.darkColorScheme.surfaceVariant,
      labelStyle: AppTextTheme.textTheme.labelMedium?.copyWith(
        color: AppColorScheme.darkColorScheme.onSurfaceVariant,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}