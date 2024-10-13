import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_app/api/user/user_api.dart';
import 'package:todo_app/api/user/user_info_database.dart';
import 'package:todo_app/api/user/user_model.dart';

class UserInfoProvider with ChangeNotifier {
  final UserDatabase _userDatabase = UserDatabase();

  // 初始化为 null
  ApiUserModel? userInfo;

  Future<ApiUserModel?> fetchUserInfoProvider() async {
    userInfo = await _userDatabase.getUserInfo();
    // 数据加载后通知监听者（UI 等）
    notifyListeners();
    return userInfo;
  }

  //由用户信息页点击保存后更新本地数据库
  Future<bool> saveUserInfoProvider(ApiUserModel user) async {
    //依次更新本地数据库和远端API
    bool apires = await updateUserInfo(user);
    await getUserInfo(); //getUserInfo里面已经完成了存储
    await fetchUserInfoProvider();
    return apires;
  }

  // 更新头像
  Future<bool> updateUserAvatar(File? filePath) async {
    if (filePath != null) {
      //上传头像后，用API获取用户信息，再更新
      bool res = await uploadAvatar(filePath);
      await getUserInfo(); //getUserInfo里面已经完成了存储
      await fetchUserInfoProvider();
      return res;
    }
    return false;
  }
}
