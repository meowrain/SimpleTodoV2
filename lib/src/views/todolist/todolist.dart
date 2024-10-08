import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/components/dialog_box.dart';
import 'package:todo_app/src/models/todo/todo.dart';
import 'package:todo_app/src/providers/todoProvider.dart';
import 'package:todo_app/src/views/todotile/todotile.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _texteditingcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    await context.read<Todoprovider>().fetchTodoProvider();
  }

  Future<void> _refreshTodos() async {
    await context.read<Todoprovider>().syncTodoListProvider();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<Todoprovider>();
    List<Todo> currentTodos = todoProvider.currentTodos;

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
        body: RefreshIndicator(
          onRefresh: _refreshTodos,
          child: ListView.builder(
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
              }),
        ));
  }

  void _checkBoxChanged(bool? value, int id) {
    setState(() {
      context.read<Todoprovider>().updateTodoProvider(id, null, value ?? false);
    });
  }

  void _saveTodoToTodoList(String? text) {
    setState(() {
      if (text != "") {
        context.read<Todoprovider>().addTodoProvider(text!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "不可以添加空的Todo",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
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
      context.read<Todoprovider>().deleteTodoProvider(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Todo已删除",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
}
