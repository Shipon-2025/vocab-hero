import 'package:flutter/material.dart';

/// Global app state provider for managing app-wide state
class AppStateProvider extends ChangeNotifier {
  bool _isFirstLaunch = true;
  bool _isOnboardingComplete = false;
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en', 'US');
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _hapticFeedbackEnabled = true;
  
  // Getters
  bool get isFirstLaunch => _isFirstLaunch;
  bool get isOnboardingComplete => _isOnboardingComplete;
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get soundEnabled => _soundEnabled;
  bool get hapticFeedbackEnabled => _hapticFeedbackEnabled;
  
  // App lifecycle methods
  void completeOnboarding() {
    _isOnboardingComplete = true;
    _isFirstLaunch = false;
    notifyListeners();
  }
  
  void setFirstLaunchComplete() {
    _isFirstLaunch = false;
    notifyListeners();
  }
  
  // Theme management
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
  
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    notifyListeners();
  }
  
  // Locale management
  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
  
  // Settings management
  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
    notifyListeners();
  }
  
  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
    notifyListeners();
  }
  
  void setHapticFeedbackEnabled(bool enabled) {
    _hapticFeedbackEnabled = enabled;
    notifyListeners();
  }
  
  // Persistence methods (to be implemented with SharedPreferences)
  Future<void> loadSettings() async {
    // TODO: Load settings from SharedPreferences
    notifyListeners();
  }
  
  Future<void> saveSettings() async {
    // TODO: Save settings to SharedPreferences
  }
}
