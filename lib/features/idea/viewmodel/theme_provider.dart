import 'package:flutter/material.dart';
import 'package:startup_idea_evaluator/features/idea/repository/idea_local_repository.dart';

class ThemeProvider extends ChangeNotifier {
  final IdeaLocalRepository _ideaLocalRepository;
  ThemeProvider(this._ideaLocalRepository) {
    _loadTheme();
  }

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void _loadTheme() {
    final isDarkMode = _ideaLocalRepository.getTheme();
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    _ideaLocalRepository.setTheme(_themeMode == ThemeMode.dark);
    notifyListeners();
  }
}
