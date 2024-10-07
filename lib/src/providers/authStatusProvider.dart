import 'package:flutter/material.dart';
import 'package:todo_app/api/auth/auth_database.dart';

class AuthStatusprovider with ChangeNotifier {
  final _authDatabase = AuthDatabase();
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
    await _authDatabase.logout();
    token = "";
    isLoggedIn = false;
    notifyListeners();
  }
}
