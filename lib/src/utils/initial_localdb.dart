import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/src/models/theme/theme.dart';
import 'package:todo_app/src/models/todo/todo.dart';

class LocalDb {
  late Isar _isar;
  Isar get isar => _isar;

  static final LocalDb _instance = LocalDb._internal();
  LocalDb._internal();
  factory LocalDb() {
    return _instance;
  }

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TodoSchema, ThemeSchema], directory: dir.path);
  }
}
