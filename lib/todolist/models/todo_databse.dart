import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:todo_app/todolist/models/todo.dart';

class TodoDatabse with ChangeNotifier {
  late Isar _isar;

  // Initialize the database
  static final TodoDatabse _instance = TodoDatabse._internal();

  TodoDatabse._internal();

// current Toods
  final List<Todo> currentTodos = [];

  factory TodoDatabse() {
    return _instance;
  }

  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([TodoSchema], directory: dir.path);
  }

  // create
  Future<void> addTodo(String task) async {
    //create todo from user give
    final newTodo = Todo()
      ..task = task
      ..completed = false;
    //write to database
    await _isar.writeTxn(() async {
      await _isar.todos.put(newTodo);
    });
    await fetchTodos();
  }

  //read
  Future<void> fetchTodos() async {
    final List<Todo> fetchTodos = await _isar.todos.where().findAll();
    currentTodos.clear();
    currentTodos.addAll(fetchTodos);
    notifyListeners();
  }

  //update

  Future<void> UpdateTodo(int id, String? newTask, bool completed) async {
    final Todo? todoToBeUpdated = await _isar.todos.get(id);
    if (todoToBeUpdated != null) {
      if (newTask == null) {
        todoToBeUpdated..completed = completed;
      } else {
        todoToBeUpdated
          ..completed = completed
          ..task = newTask;
      }
      await _isar.writeTxn(() async {
        await _isar.todos.put(todoToBeUpdated);
        await fetchTodos();
      });
    }
  }

  //delete
  Future<void> DeleteTodo(int id) async {
    final Todo? todoToBeDeleted = await _isar.todos.get(id);
    if (todoToBeDeleted != null) {
      await _isar.writeTxn(() async {
        final success = await _isar.todos.delete(id);
        print('Recipe deleted: $success');
        await fetchTodos();
      });
    }
  }
}
