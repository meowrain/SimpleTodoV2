import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:todo_app/api/todo/todo_model.dart';
import 'package:todo_app/config/config_init.dart';
import 'package:todo_app/config/config_model.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/src/db/todo_databse.dart';
import 'package:todo_app/src/models/todo/todo.dart';
import '../auth/auth_database.dart';

//TODO: 添加未登录的提示
var logger = Logger();

Future<List<Todo>?> fetchTodoListAPI() async {
  final ConfigModel config = ConfigManager().config;
  final Uri apiUrl = Uri.parse("${config.apiUrl}/todos/all");
  final authDatabase = AuthDatabase();
  bool isLoggedIn = await authDatabase.isLoggedIn();

  if (isLoggedIn) {
    // 构建请求头
    Map<String, String> headers = <String, String>{};
    headers['Content-Type'] = 'application/json';
    headers['Authorization'] = (await authDatabase.getToken())!;

    final response = await http.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      logger.i("从API获取Todo List成功！");
      // 解析 JSON 对象
      Map<String, dynamic> jsonResponseBody = jsonDecode(response.body);

      // 获取 data 字段中的数组
      List<dynamic> jsonData = jsonResponseBody['data'];
      // 将 JSON 数组映射到 ApiTodoModel 列表
      List<ApiTodoModel> todoList =
          jsonData.map((item) => ApiTodoModel.fromJson(item)).toList();
      //转换成数据库中的todo list
      List<Todo> todos = todoList.map((apitodo) => apitodo.toTodo()).toList();
      TodoDatabse todoDatabse = TodoDatabse();
      //先清空
      await todoDatabse.DeleteAllTodo();
      //然后添加
      await todoDatabse.addAllTodo(todos);
      return todos;
    }
  }
  return [];
}

Future<bool> syncTodoListAPI({required List<ApiTodoModel> todoList}) async {
  final ConfigModel config = ConfigManager().config;
  final Uri apiUrl = Uri.parse("${config.apiUrl}/todos/all");
  final authDatabase = AuthDatabase();
  bool isLoggedIn = await authDatabase.isLoggedIn();
  if (isLoggedIn) {
    //如果已经登录，那么可以执行更新数据的操作
    //构建请求头
    Map<String, String> headers = <String, String>{};
    headers['Content-Type'] = 'application/json';
    headers['Authorization'] = (await authDatabase.getToken())!;

    //构建请求体

    final body = jsonEncode(todoList.map((todo) => todo.toJson()).toList());
    //发送请求
    final response = await http.put(apiUrl, headers: headers, body: body);
    // 处理响应
    if (response.statusCode == 200) {
      // 更新成功
      logger.i("更新todoList成功！");
      return true;
    } else {
      logger.e("更新失败");
      return false;
    }
  }
  return false;
}
