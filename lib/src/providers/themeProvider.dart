import 'package:flutter/material.dart';
import 'package:todo_app/api/todo/todo_api.dart';
import 'package:todo_app/src/db/theme_database.dart';
import 'package:todo_app/src/theme/theme_manager.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String _theme = "midnight"; // 设置默认主题为midnight
  ThemeMode get themeMode => _themeMode;
  String get theme => _theme;

  final Themedatabase _themedatabase = Themedatabase();

  ThemeProvider() {
    _loadThemeSettings();
  }

  // 从数据库加载主题模式和主题名
  Future<void> _loadThemeSettings() async {
    try {
      String? themeModeFromDatabase = await _themedatabase.fetchThemeModeFromDB();
      if (themeModeFromDatabase != null) {
        _themeMode = themeModeFromDatabase == 'dark' ? ThemeMode.dark : ThemeMode.light;
      }

      String? themeFromDatabase = await _themedatabase.fetchThemeNameFromDB();
      if (themeFromDatabase != null) {
        _theme = themeFromDatabase;
      }

      notifyListeners();
    } catch (e) {
      // 处理异常情况
      logger.e("Error loading theme settings: $e");
    }
  }

  // 切换主题模式
  void toggleTheme(bool isOn) async {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    await _themedatabase.saveThemeDB(_theme, isOn ? 'dark' : 'light');
    notifyListeners();
  }

  // 切换主题
  void changeTheme(String themeName, BuildContext context) async {
    if (_theme != themeName) {
      _theme = themeName;
      await _themedatabase.saveThemeDB(isDarkMode(context) ? 'dark' : 'light', themeName);
      notifyListeners();
    }
  }

  bool isDarkMode(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }



// 根据主题名返回对应的 ThemeData
  List<ThemeData> get themeData {
    switch (_theme) {
      case 'midnight':
        return [
          ThemeManager.LightTheme.midnight,
          ThemeManager.DarkTheme.midnight
        ];
      case 'red_and_blue':
        return [
          ThemeManager.LightTheme.red_and_blue,
          ThemeManager.DarkTheme.red_and_blue
        ];
      case 'greens':
        return [ThemeManager.LightTheme.greens, ThemeManager.DarkTheme.greens];
      case 'material_default':
        return [
          ThemeManager.LightTheme.material_default,
          ThemeManager.DarkTheme.material_default
        ];
      case 'material_high_contract':
        return [
          ThemeManager.LightTheme.material_high_contract,
          ThemeManager.DarkTheme.material_high_contract
        ];
      case 'blue_delight':
        return [
          ThemeManager.LightTheme.blue_delight,
          ThemeManager.DarkTheme.blue_delight
        ];
      case 'indigo_nights':
        return [
          ThemeManager.LightTheme.indigo_nights,
          ThemeManager.DarkTheme.indigo_nights
        ];
    // 可以继续添加其他主题
      default:
        return [
          ThemeManager.LightTheme.midnight,
          ThemeManager.DarkTheme.midnight
        ];
    }
  }
}
