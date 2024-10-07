

import 'package:todo_app/src/models/todo/todo.dart';

class ApiTodoModel {
  final String content;
  final bool completed;
  final String tag;

  ApiTodoModel({required this.content,required this.completed, required this.tag});

  factory ApiTodoModel.fromJson(Map<String, dynamic> data) {
    return ApiTodoModel(
    completed: data['completed'], tag: data['tag'],content: data['content']);
  }
  // 从 ApiTodoModel 转换为 Todo
  Todo toTodo() {
    Todo todo = Todo();
    todo.task=content;
    todo.completed = completed;
    return todo;
  }
  Map<String,dynamic> toJson() {
    return {
      'completed': completed,
      'tag': tag,
      'content': content
    };
  }
}
