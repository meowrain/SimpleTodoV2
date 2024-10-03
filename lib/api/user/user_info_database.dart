import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/api/user/user_model.dart';

class UserDatabase {
  var logger = Logger();
  Future<void> saveUserInfo(ApiUserModel user) async {
    logger.i('存储用户信息');
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('user_id', user.id);
    await pref.setString('username', user.username);
    await pref.setString('gender', user.gender);
    await pref.setString('avatar', user.avatar);
    await pref.setString('bio', user.bio);
    await pref.setString('email', user.email);
    await pref.setString('phoneNumber', user.phoneNumber);
    await pref.setString('birthday', user.birthday);
  }

  Future<ApiUserModel?> getUserInfo() async {
    logger.i("从本地数据库获取用户信息");
    final pref = await SharedPreferences.getInstance();
    final id = pref.getInt('user_id');
    final username = pref.getString('username');
    final gender = pref.getString('gender');
    final avatar = pref.getString('avatar');
    final bio = pref.getString('bio');
    final email = pref.getString('email');
    final phoneNumber = pref.getString('phoneNumber');
    final birthday = pref.getString('birthday');

    if (id == null ||
        username == null ||
        gender == null ||
        avatar == null ||
        bio == null ||
        email == null ||
        phoneNumber == null ||
        birthday == null) {
      return null;
    }

    ApiUserModel user = ApiUserModel(
      id: id,
      username: username,
      avatar: avatar,
      bio: bio,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      birthday: birthday,
    );
    return user;
  }
}
