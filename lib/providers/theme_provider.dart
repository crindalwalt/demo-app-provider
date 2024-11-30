import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _currentThemeMode = ThemeMode.light;
  ThemeMode get mode => _currentThemeMode;
}
