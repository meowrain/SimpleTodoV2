import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:todo_app/api/auth/auth_database.dart';
import 'package:todo_app/api/todo/todo_api.dart';
import 'package:todo_app/api/user/user_info_database.dart';
import 'package:todo_app/api/user/user_model.dart';
import 'package:todo_app/config/config_init.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();

/// 通用的 HTTP 请求函数，封装常见的请求逻辑
Future<http.Response?> _sendHttpRequest({
  required Uri url,
  required String method,
  Map<String, String>? headers,
  String? body,
  File? file,
  Duration timeout = const Duration(seconds: 10),
}) async {
  try {
    var request;
    if (method == 'POST' && file != null) {
      // 文件上传请求
      var multipartRequest = http.MultipartRequest('POST', url)
        ..headers.addAll(headers ?? {})
        ..files.add(await http.MultipartFile.fromPath('avatar', file.path));
      var streamedResponse = await multipartRequest.send();
      return http.Response.fromStream(streamedResponse);
    }

    // 普通请求
    switch (method) {
      case 'GET':
        request = http.get(url, headers: headers);
        break;
      case 'POST':
        request = http.post(url, headers: headers, body: body);
        break;
      case 'PUT':
        request = http.put(url, headers: headers, body: body);
        break;
      default:
        throw ArgumentError('Unsupported HTTP method: $method');
    }

    return await request.timeout(timeout);
  } catch (e) {
    logger.e('请求错误: $e');
    return null;
  }
}

/// 构建包含 Authorization 的请求头
Future<Map<String, String>> _buildHeaders() async {
  final authDatabase = AuthDatabase();
  String? token = await authDatabase.getToken();
  return {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': token,
  };
}

/// 登录
Future<bool> login({String? username, String? password}) async {
  final config = ConfigManager().config;
  final apiUrl = Uri.parse("${config.apiUrl}/users/login");
  String body = jsonEncode({'username': username, 'password': password});
  final headers = {'Content-Type': 'application/json'};

  final response = await _sendHttpRequest(
    url: apiUrl,
    method: 'POST',
    headers: headers,
    body: body,
  );

  if (response?.statusCode == 200) {
    logger.i('登录成功: ${response!.body}');
    var token = jsonDecode(response.body)['data'];
    var authDatabase = AuthDatabase();
    await authDatabase.storeToken(token);
    await authDatabase.storeLoggedStatus(true);
    await getUserInfo();
    await fetchTodoListAPI();
    return true;
  } else {
    logger.e('登录失败: ${response?.body}');
    return false;
  }
}

/// 注册
Future<bool> register({String? username, String? password}) async {
  final config = ConfigManager().config;
  final apiUrl = Uri.parse('${config.apiUrl}/users/register');
  String body = jsonEncode({'username': username, 'password': password});

  final response = await _sendHttpRequest(
    url: apiUrl,
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: body,
  );

  if (response?.statusCode == 200) {
    logger.i('注册成功: ${response!.body}');
    return true;
  } else {
    logger.e('注册失败: ${response?.body}');
    return false;
  }
}

/// 获取用户信息
Future<ApiUserModel?> getUserInfo() async {
  final authDatabase = AuthDatabase();
  if (await authDatabase.isLoggedIn()) {
    final config = ConfigManager().config;
    final apiUrl = Uri.parse('${config.apiUrl}/users/info');
    final headers = await _buildHeaders();

    final response = await _sendHttpRequest(
      url: apiUrl,
      method: 'GET',
      headers: headers,
    );

    if (response?.statusCode == 200) {
      var user = ApiUserModel.fromJson(jsonDecode(response!.body)['data']);
      logger.i('获取用户信息成功: $user');
      await UserDatabase().saveUserInfo(user);
      return user;
    } else {
      logger.e('获取用户信息失败: ${response?.body}');
    }
  }
  return null;
}

/// 上传头像
Future<bool> uploadAvatar(File imageFile) async {
  final config = ConfigManager().config;
  final apiUrl = Uri.parse('${config.apiUrl}/users/upload_avatar');
  final headers = await _buildHeaders();

  final response = await _sendHttpRequest(
    url: apiUrl,
    method: 'POST',
    headers: headers,
    file: imageFile,
  );

  if (response?.statusCode == 200) {
    logger.i('头像上传成功');
    return true;
  } else {
    logger.e('头像上传失败: ${response?.body}');
    return false;
  }
}

/// 更新用户信息
Future<bool> updateUserInfo(ApiUserModel userModel) async {
  final config = ConfigManager().config;
  final apiUrl = Uri.parse('${config.apiUrl}/users/update');
  final headers = await _buildHeaders();
  String body = jsonEncode(userModel);

  final response = await _sendHttpRequest(
    url: apiUrl,
    method: 'PUT',
    headers: headers,
    body: body,
  );

  if (response?.statusCode == 200) {
    logger.i('更新用户信息成功');
    return true;
  } else {
    logger.e('更新用户信息失败: ${response?.body}');
    return false;
  }
}

/// 更新用户密码
Future<bool> updateUserPassword(String password) async {
  final config = ConfigManager().config;
  final apiUrl = Uri.parse('${config.apiUrl}/users/password');
  final headers = await _buildHeaders();
  String body = jsonEncode({'password': password});

  final response = await _sendHttpRequest(
    url: apiUrl,
    method: 'POST',
    headers: headers,
    body: body,
  );

  if (response?.statusCode == 200) {
    logger.i('更新用户密码成功');
    return true;
  } else {
    logger.e('更新用户密码失败: ${response?.body}');
    return false;
  }
}
