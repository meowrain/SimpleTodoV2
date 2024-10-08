import 'package:flutter/material.dart';
import 'package:todo_app/api/auth/auth_database.dart';
import 'package:todo_app/src/db/todo_databse.dart';

class AuthStatusprovider with ChangeNotifier {
  final _authDatabase = AuthDatabase();
  final _todoDatabase = TodoDatabse();
  String? token = "";
  var isLoggedIn = false;
  Future<void> getTokenProvider() async {
    token = await _authDatabase.getToken();
    notifyListeners();
  }

  Future<void> isLoggedInProvider() async {
    isLoggedIn = await _authDatabase.isLoggedIn();
    notifyListeners();
  }

  Future<void> logoutProvider() async {
    //清空用户信息
    await _authDatabase.logout();
    //删除Todo信息
    await _todoDatabase.DeleteAllTodo();
    token = "";
    isLoggedIn = false;
    notifyListeners();
  }
}
