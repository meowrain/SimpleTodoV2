class ConfigModel {
  final String apiUrl;

  ConfigModel({
    required this.apiUrl,
  });

  // 工厂构造函数，用于从 Map 转换成 ConfigModel 对象
  factory ConfigModel.fromMap(Map<String, dynamic> map) {
    return ConfigModel(
      apiUrl: map['api_url'], // 注意：这里的 key 应该与你的 YAML 文件字段匹配
    );
  }

  @override
  String toString() {
    return 'ConfigModel(apiUrl: $apiUrl)';
  }
}
