import 'package:isar/isar.dart';
import 'package:todo_app/src/models/todo/todo.dart';
import 'package:todo_app/src/utils/initial_localdb.dart';

class TodoDatabse {
  final Isar _isar = LocalDb().isar;
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
  }

  //read
  Future<List<Todo>> fetchTodos() async {
    final List<Todo> fetchTodos = await _isar.todos.where().findAll();
    return fetchTodos;
  }

  //update

  Future<void> UpdateTodo(int id, String? newTask, bool completed) async {
    final Todo? todoToBeUpdated = await _isar.todos.get(id);
    if (todoToBeUpdated != null) {
      if (newTask == null) {
        todoToBeUpdated.completed = completed;
      } else {
        todoToBeUpdated
          ..completed = completed
          ..task = newTask;
      }
      await _isar.writeTxn(() async {
        await _isar.todos.put(todoToBeUpdated);
      });
    }
  }

  //delete
  Future<void> DeleteTodo(int id) async {
    final Todo? todoToBeDeleted = await _isar.todos.get(id);
    if (todoToBeDeleted != null) {
      await _isar.writeTxn(() async {
        await _isar.todos.delete(id);
      });
    }
  }
}