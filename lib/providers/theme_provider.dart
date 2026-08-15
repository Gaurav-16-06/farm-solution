import 'package:flutter/material.dart';
import '../core/services/hive_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  final HiveService _hiveService;

  ThemeProvider(this._hiveService) {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void _loadTheme() {
    final isDark = _hiveService.getSetting('is_dark_mode', defaultValue: false);
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _hiveService.saveSetting('is_dark_mode', _themeMode == ThemeMode.dark);
    notifyListeners();
  }
}
