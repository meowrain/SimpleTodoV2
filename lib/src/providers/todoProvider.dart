import 'package:flutter/material.dart';
import 'package:todo_app/api/todo/todo_api.dart';
import 'package:todo_app/api/todo/todo_model.dart';
import 'package:todo_app/src/db/todo_databse.dart';
import 'package:todo_app/src/models/todo/todo.dart';

class Todoprovider with ChangeNotifier {
  final TodoDatabse _todoDatabase = TodoDatabse();
  final List<Todo> currentTodos = [];
  Future<void> updateTodoProvider(
      int id, String? newTask, bool completed) async {
    await _todoDatabase.UpdateTodo(id, newTask, completed);
    await fetchTodoProvider();
  }

  Future<void> fetchTodoProvider() async {
    final fetchTodos = await _todoDatabase.fetchTodos();
    currentTodos.clear();
    currentTodos.addAll(fetchTodos);
    notifyListeners();
  }

  Future<void> addTodoProvider(String task) async {
    await _todoDatabase.addTodo(task);
    await fetchTodoProvider();
  }

  Future<void> deleteTodoProvider(int id) async {
    await _todoDatabase.DeleteTodo(id);
    await fetchTodoProvider();
  }

  // 调用API同步
  Future<void> syncTodoListProvider() async {
    final fetchTodos = await _todoDatabase.fetchTodos();
    final todoListReq = fetchTodos.map((todo) {
      return ApiTodoModel(
        content: todo.task!,
        completed: todo.completed!,
        // TODO: 添加todo字段
        tag: "",
      );
    }).toList();
    //调用syncTodoListAPI进行同步
    bool res = await syncTodoListAPI(todoList: todoListReq);
    // 如果同步成功，刷新本地数据
    if (res) {
      //更新本地数据库数据
      await fetchTodoListAPI();
      //更新provider数据
      await fetchTodoProvider();
    } else {
      //如果返回false,也就是未登录状态，就调用fetchTodoProvider更新provider
      await fetchTodoProvider();
    }
  }
}
