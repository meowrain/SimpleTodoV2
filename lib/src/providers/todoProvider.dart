import 'package:flutter/material.dart';
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
}
