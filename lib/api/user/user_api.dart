import 'dart:convert';

import 'package:todo_app/api/auth/auth_database.dart';
import 'package:todo_app/api/todo/todo_api.dart';
import 'package:todo_app/api/user/user_info_database.dart';
import 'package:todo_app/api/user/user_model.dart';
import 'package:todo_app/config/config_init.dart';
import 'package:todo_app/config/config_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();
Future<bool> login({String? username, String? password}) async {
  final ConfigModel config = ConfigManager().config;
  final apiUrl = Uri.parse("${config.apiUrl}/users/login");

  //构建请求头
  Map<String, String> headers = <String, String>{};
  headers['Content-Type'] = 'application/json';

  //构建请求体
  String body = jsonEncode({
    'username': username,
    'password': password,
  });

// 发送请求
  final response = await http.post(
    apiUrl,
    headers: headers,
    body: body,
  );

  //检查响应状态
  if (response.statusCode == 200) {
    logger.i('Login Successful: ${response.body}');
    // 解析 JSON
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    // 提取 data 字段,也就是token
    var token = jsonResponse['data'];
    var authDatabase = AuthDatabase();
    await authDatabase.storeToken(token);
    await authDatabase.storeLoggedStatus(true);
    //登录成功后，我们获取user的信息，执行其中的逻辑，包括更新本地sharedPreference
    await getUserInfo();
    await fetchTodoListAPI();
    return true;
  } else {
    logger.e('Falied to login: ${response.body}');
    return false;
  }
}

Future<bool> register({String? username, String? password}) async {
  final ConfigModel config = ConfigManager().config;
  final apiUrl = Uri.parse('${config.apiUrl}/users/register');

  Map<String, String> header = <String, String>{};
  header['Content-Type'] = 'application/json';

  String body = jsonEncode({'username': username, 'password': password});

  final response = await http.post(apiUrl, headers: header, body: body);
  if (response.statusCode == 200) {
    logger.i('Register Successful: ${response.body}');
    return true;
  } else {
    logger.e('Failed to register: ${response.body}');
    return false;
  }
}

Future<ApiUserModel?> getUserInfo() async {
  final authDatabase = AuthDatabase();
  final userInfoDatabase = UserDatabase();
  bool isLoggedIn = await authDatabase.isLoggedIn();
  if (isLoggedIn) {
    final ConfigModel config = ConfigManager().config;

    final apiUrl = Uri.parse('${config.apiUrl}/users/info');
    Map<String, String> headers = <String, String>{};
    headers['Content-Type'] = 'application/json';
    headers['Authorization'] = (await authDatabase.getToken())!;
    final response = await http.get(apiUrl, headers: headers);
    Map<String, dynamic> json_responseBody = jsonDecode(response.body);

    ApiUserModel? user = ApiUserModel.fromJson(json_responseBody['data']);

    if (response.statusCode == 200) {
      logger.i('Get User Info Successful: ${user}');
      //获取一次就更新一次user的相关字段
      await userInfoDatabase.saveUserInfo(user);
      return user;
    } else {
      logger.e('Get User Info failed: ${response.body}');
      return null;
    }
  } else {
    return null;
  }
}
