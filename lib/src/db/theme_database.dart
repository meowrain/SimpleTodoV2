import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:todo_app/src/models/theme/theme.dart';
import 'package:todo_app/src/utils/initial_localdb.dart';

class Themedatabase {
  final Isar _isar = LocalDb().isar;
  final logger = Logger();
  Future<void> saveThemeDB(String themeMode, String themeName) async {
    final theme = Theme()
      ..id = 0
      ..themeMode = themeMode
      ..theme = themeName;

    await _isar.writeTxn(() async {
      await _isar.themes.put(theme);
      logger.i("Theme saved: mode=$themeMode, name=$themeName"); // 添加调试日志
    });
  }


  Future<String?> fetchThemeModeFromDB() async {
    final theme = await _isar.themes.get(0);
    return theme?.themeMode;
  }
  Future<String?> fetchThemeNameFromDB() async {
    final theme = await _isar.themes.get(0);
    return theme?.theme;
  }
}
