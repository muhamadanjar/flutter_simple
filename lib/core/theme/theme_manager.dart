// lib/core/theme/theme_manager.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemePreference { system, light, dark }

class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  static const String _themePreferenceKey = 'theme_preference';

  ThemeManager() {
    _loadThemePreference();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themePreferenceKey);

    if (themeString != null) {
      _themeMode = _getThemeModeFromString(themeString);
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();

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

  bool get isLightMode =>
      _themeMode == ThemeMode.light ||
          (_themeMode == ThemeMode.system &&
              WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.light);

  bool get isDarkMode =>
      _themeMode == ThemeMode.dark ||
          (_themeMode == ThemeMode.system &&
              WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);

  ThemePreference get currentThemePreference {
    switch (_themeMode) {
      case ThemeMode.light:
        return ThemePreference.light;
      case ThemeMode.dark:
        return ThemePreference.dark;
      default:
        return ThemePreference.system;
    }
  }
}