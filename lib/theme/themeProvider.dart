import 'package:flutter/material.dart';
import 'package:todo_app/theme/db/theme_database.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  final Themedatabase _themedatabase = Themedatabase();
  ThemeProvider() {
    _loadThemeFromDatabase();
  }
  Future<void> _loadThemeFromDatabase() async {
    String? themeFromDatabase = await _themedatabase.fetchThemeFromDB();
    if (themeFromDatabase != null) {
      print(themeFromDatabase);
      _themeMode =
          themeFromDatabase == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }

  void toggleTheme(bool isOn, BuildContext context) async {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    await _themedatabase.saveThemeDB(isOn ? 'dark' : 'light');
    notifyListeners();
  }

  bool isDarkMode(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }
}
