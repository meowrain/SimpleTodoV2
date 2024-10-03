import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDatabase {
  var logger = Logger();
  //存储JWT
  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await storeLoggedStatus(true);
    await prefs.setString('jwt_token', token);

    logger.i('存储jwtToken');
  }

  //获取Jwt Token
  Future<String?> getToken() async {
    logger.i('获取jwtToken');
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

// 存储登录状态
  Future<void> storeLoggedStatus(bool status) async {
    logger.i('存储登录状态');
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('is_logged_in', status);
  }

  //返回登录状态
  Future<bool> isLoggedIn() async {
    logger.i('返回登录状态');
    final pref = await SharedPreferences.getInstance();
    return pref.getBool('is_logged_in') ?? false; //如果里面为false或者null，就返回false
  }

  // 登出
  Future<void> logout() async {
    logger.i('登出当前用户');
    final pref = await SharedPreferences.getInstance();
    //删除登录信息
    await pref.remove('jwt_token');
    await pref.setBool('is_logged_in', false);
    //删除用户信息
    await pref.remove('user_id');
    await pref.remove('username');
    await pref.remove('gender');
    await pref.remove('avatar');
    await pref.remove('bio');
    await pref.remove('email');
    await pref.remove('phoneNumber');
    await pref.remove('birthday');
  }
}
