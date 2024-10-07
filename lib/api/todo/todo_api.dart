import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:todo_app/api/todo/todo_model.dart';
import 'package:todo_app/config/config_init.dart';
import 'package:todo_app/config/config_model.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/src/db/todo_databse.dart';
import 'package:todo_app/src/models/todo/todo.dart';
import '../auth/auth_database.dart';

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
