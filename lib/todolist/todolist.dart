import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/todolist/models/todo.dart';
import 'package:todo_app/todolist/models/todo_databse.dart';
import 'package:todo_app/todolist/todotile.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _texteditingcontroller = TextEditingController();

  void _checkBoxChanged(bool? value, int id) {
    setState(() {
      context.read<TodoDatabse>().UpdateTodo(id, null, value ?? false);
      // [index]['completed'] = value ?? false;
    });
  }

  void _saveTodoToTodoList(String? text) {
    setState(() {
      if (text != "") {
        context.read<TodoDatabse>().addTodo(text!);
      } else {
        toastification.show(description: const Text("不可以添加空的Todo"));
      }
    });
  }

  void readTasksFromDatabase() {
    context.watch<TodoDatabse>().fetchTodos();
  }

  void _createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
              controller: _texteditingcontroller,
              onSave: () {
                var text = _texteditingcontroller.text;
                _saveTodoToTodoList(text);
                _texteditingcontroller.clear(); // 清空文本框
                Navigator.of(context).pop();
              },
              onCancel: () {
                _texteditingcontroller.clear(); // 清空文本框
                Navigator.of(context).pop();
              });
        });
  }

  void _deleteFromTheTask(int id) {
    setState(() {
      context.read<TodoDatabse>().DeleteTodo(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final todoDatabase = context.watch<TodoDatabse>();
    List<Todo> currentTodos = todoDatabase.currentTodos;
    todoDatabase.fetchTodos();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          onPressed: _createNewTask,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          elevation: 5,
          child:
              Icon(Icons.add, color: Theme.of(context).colorScheme.onSecondary),
        ),
        body: ListView.builder(
            itemCount: currentTodos.length,
            itemBuilder: (context, index) {
              return TodoTile(
                taskName: currentTodos[index].task!,
                taskCompleted: currentTodos[index].completed!,
                onChanged: (bool? value) {
                  _checkBoxChanged(value, currentTodos[index].id);
                },
                deleteTodoFromTodoList: (context) {
                  _deleteFromTheTask(currentTodos[index].id);
                },
              );
            }));
  }
}
