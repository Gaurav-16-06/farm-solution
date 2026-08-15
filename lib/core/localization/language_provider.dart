import 'package:flutter/material.dart';
import '../services/hive_service.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('hi'); // Default Hindi for rural farmers
  final HiveService _hiveService;

  LanguageProvider(this._hiveService) {
    _loadLanguagePreference();
  }

  Locale get currentLocale => _currentLocale;
  bool get isHindi => _currentLocale.languageCode == 'hi';

  void _loadLanguagePreference() {
    final savedCode = _hiveService.getSetting('language_code', defaultValue: 'hi');
    _currentLocale = Locale(savedCode);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_currentLocale == locale) return;
    _currentLocale = locale;
    await _hiveService.saveSetting('language_code', locale.languageCode);
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    final newCode = _currentLocale.languageCode == 'hi' ? 'en' : 'hi';
    await setLocale(Locale(newCode));
  }
}
