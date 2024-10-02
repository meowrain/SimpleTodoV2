import 'package:isar/isar.dart';
import 'package:todo_app/theme/models/theme.dart';
import 'package:todo_app/utils/initial_localdb.dart';

class Themedatabase {
  final Isar _isar = LocalDb().isar;

  Future<void> saveThemeDB(String themeMode) async {
    final theme = Theme()
      ..id = 0 // Ensure a single record with a fixed ID
      ..themeMode = themeMode;
    await _isar.writeTxn(() async {
      await _isar.themes.put(theme);
    });
  }

  Future<String?> fetchThemeFromDB() async {
    final theme = await _isar.themes.get(0);
    return theme?.themeMode;
  }
}
