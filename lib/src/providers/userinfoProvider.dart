import 'package:flutter/material.dart';
import 'package:todo_app/api/user/user_info_database.dart';
import 'package:todo_app/api/user/user_model.dart';

class UserInfoProvider with ChangeNotifier {
  final UserDatabase _authDatabase = UserDatabase();

  // 初始化为 null
  ApiUserModel? userInfo;

  Future<void> fetchUserInfoProvider() async {
    userInfo = await _authDatabase.getUserInfo();
    // 数据加载后通知监听者（UI 等）
    notifyListeners();
  }
}
