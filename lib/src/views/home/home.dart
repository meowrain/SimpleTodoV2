import 'package:flutter/material.dart';
import 'package:todo_app/src/views/user/login/login.dart';
import 'package:todo_app/src/views/settings/settings.dart';
import 'package:todo_app/src/views/todolist/todolist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;

  final List<dynamic> routes = const [TodoList(), Settings()];
  void _changeCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pure Todo",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: routes[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "主页"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "设置"),
        ],
        currentIndex: _currentIndex,
        onTap: _changeCurrentIndex,
      ),
    );
  }
}
