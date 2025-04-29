import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Enum untuk preferensi tema
enum ThemePreference { system, light, dark }

// Provider untuk menyimpan ThemeMode
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

// Provider untuk mengecek apakah tema saat ini adalah light mode
final isLightModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeProvider);
  return themeMode == ThemeMode.light ||
      (themeMode == ThemeMode.system &&
          WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.light);
});

// Provider untuk mengecek apakah tema saat ini adalah dark mode
final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeProvider);
  return themeMode == ThemeMode.dark ||
      (themeMode == ThemeMode.system &&
          WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);
});

// StateNotifier untuk mengontrol tema
class ThemeNotifier extends StateNotifier<ThemeMode> {
  static const String _themePreferenceKey = 'theme_preference';

  ThemeNotifier() : super(ThemeMode.system) {
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themePreferenceKey);

    if (themeString != null) {
      state = _getThemeModeFromString(themeString);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state == mode) return;

    state = mode;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themePreferenceKey, _getStringFromThemeMode(mode));
  }

  ThemeMode _getThemeModeFromString(String themeString) {
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _getStringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

  ThemePreference get currentThemePreference {
    switch (state) {
      case ThemeMode.light:
        return ThemePreference.light;
      case ThemeMode.dark:
        return ThemePreference.dark;
      default:
        return ThemePreference.system;
    }
  }
}