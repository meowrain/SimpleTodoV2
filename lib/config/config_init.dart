import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';
import 'package:todo_app/config/config_model.dart';

class ConfigManager {
  static final ConfigManager _instance = ConfigManager._internal();
  static ConfigModel? _config;

  factory ConfigManager() {
    return _instance;
  }

  ConfigManager._internal();

  Future<void> init() async {
    if (_config == null) {
      final yamlString =
          await rootBundle.loadString('assets/config/config.yaml');
      final yamlMap = loadYaml(yamlString);
      final configMap = jsonDecode(jsonEncode(yamlMap));
      _config = ConfigModel.fromMap(configMap);
    }
  }

  ConfigModel get config => _config!;
}
