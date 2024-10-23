import 'dart:convert';
import 'dart:async';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/api/todo/todo_model.dart';
import 'package:todo_app/config/config_init.dart';
import 'package:todo_app/config/config_model.dart';
import 'package:todo_app/src/db/todo_databse.dart';
import 'package:todo_app/src/models/todo/todo.dart';
import '../auth/auth_database.dart';

var logger = Logger();

// 公共方法：获取请求头
Future<Map<String, String>> _buildHeaders() async {
  final authDatabase = AuthDatabase();
  String? token = await authDatabase.getToken();
  return {
    'Content-Type': 'application/json',
    'Authorization': token ?? '',
  };
}

// 公共方法：检查是否已登录
Future<bool> _checkLoginStatus() async {
  final authDatabase = AuthDatabase();
  bool isLoggedIn = await authDatabase.isLoggedIn();
  if (!isLoggedIn) {
    logger.e("用户未登录");
    return false;
  }
  return true;
}

// 从 API 获取 Todo 列表
Future<List<Todo>?> fetchTodoListAPI() async {
  if (!await _checkLoginStatus()) return [];

  final ConfigModel config = ConfigManager().config;
  final Uri apiUrl = Uri.parse("${config.apiUrl}/todos/all");

  try {
    Map<String, String> headers = await _buildHeaders();
    final response = await http.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      logger.i("从 API 获取 Todo List 成功！");
      Map<String, dynamic> jsonResponseBody = jsonDecode(response.body);
      List<dynamic> jsonData = jsonResponseBody['data']['todos'];

      List<ApiTodoModel> apiTodoList = jsonData.map((item) => ApiTodoModel.fromJson(item)).toList();
      List<Todo> todos = apiTodoList.map((apiTodo) => apiTodo.toTodo()).toList();

      TodoDatabse todoDatabase = TodoDatabse();
      await todoDatabase.DeleteAllTodo();
      await todoDatabase.addAllTodo(todos);

      return todos;
    } else {
      logger.e("API 响应失败：${response.body}");
    }
  } catch (e) {
    logger.e("获取 Todo 列表时发生错误：$e");
  }

  return [];
}

// 同步 Todo 列表到 API
Future<bool> syncTodoListAPI({required List<ApiTodoModel> todoList}) async {
  if (!await _checkLoginStatus()) return false;

  final ConfigModel config = ConfigManager().config;
  final Uri apiUrl = Uri.parse("${config.apiUrl}/todos/all");

  try {
    Map<String, String> headers = await _buildHeaders();
    final body = jsonEncode(todoList.map((todo) => todo.toJson()).toList());

    final response = await http.put(apiUrl, headers: headers, body: body);

    if (response.statusCode == 200) {
      logger.i("同步 Todo 列表成功！");
      return true;
    } else {
      logger.e("同步失败：${response.body}");
    }
  } catch (e) {
    logger.e("同步 Todo 列表时发生错误：$e");
  }

  return false;
}
