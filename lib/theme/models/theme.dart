import 'package:isar/isar.dart';

part 'theme.g.dart';

@collection
class Theme {
  Id id = Isar.autoIncrement;
  String? themeMode;
}
