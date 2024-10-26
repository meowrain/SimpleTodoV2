import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/providers/authStatusProvider.dart';
import 'package:todo_app/src/providers/userinfoProvider.dart';
import 'package:todo_app/src/views/about/about.dart';
import 'package:todo_app/src/views/privacy_policy/privacy_policy.dart';
import 'package:todo_app/src/providers/themeProvider.dart';
import 'package:todo_app/src/views/user/login/login.dart';
import 'package:todo_app/src/views/user/profile.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notificationsEnabled = true;
  final List<String> _themes = ['midnight','greens','blue_delight','indigo_nights','material_default','material_high_contract','red_and_blue'];
  // 每次打开的时候调用一次，更新userInfoProvider全局状态
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    final userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    final authStatusProvider =
        Provider.of<AuthStatusprovider>(context, listen: false);

    //刷新用户登录状态
    await authStatusProvider.isLoggedInProvider();
    //刷新用户信息
    await userInfoProvider.fetchUserInfoProvider();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    final authStatusProvider = Provider.of<AuthStatusprovider>(context);
    //获取登录状态，如果是没有登录，下面的注销按钮要进行相应的变化
    final isLoggedIn = authStatusProvider.isLoggedIn;
    // 从 userInfoProvider 提取 userInfo,如果为空，就返回？？后面的
    final username = userInfoProvider.userInfo?.username ?? "未登录";
    final avatar = userInfoProvider.userInfo?.avatar ?? '';
    final bio = userInfoProvider.userInfo?.bio ?? '';

    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: avatar.isNotEmpty
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(avatar),
                          onBackgroundImageError: (error, stackTrace) {
                            // Handle image loading error
                            print('Image loading error: $error');
                          },
                        )
                      : const Icon(
                          size: 100.0, FluentIcons.person_circle_28_regular),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(bio,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal))
                    ],
                  ),
                ),
              ],
            ),
          ),
          isLoggedIn
              ? ListTile(
                  leading: const Icon(FluentIcons.person_24_regular),
                  title: const Text('账户'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PersonalPageDemo()));
                  },
                )
              : const SizedBox.shrink(),
          ListTile(
            leading: const Icon(FluentIcons.lock_closed_24_regular),
            title: const Text('隐私'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyPage()));
            },
          ),
          /*SwitchListTile(
            secondary: const Icon(FluentIcons.alert_24_regular),
            title: const Text('通知'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),*/
          SwitchListTile(
            secondary: const Icon(FluentIcons.dark_theme_24_regular),
            title: const Text('夜间模式'),
            value: themeProvider.isDarkMode(context),
            onChanged: (bool value) {
              setState(() {
                themeProvider.toggleTheme(value);
              });
            },
          ),
          ListTile(
            leading: const Icon(FluentIcons.dark_theme_24_regular),
            title: const Text('选择主题'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemeDialog(context, themeProvider), // 显示主题选择对话框
          ),
          ListTile(
            leading: const Icon(FluentIcons.info_24_regular),
            title: const Text('关于'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const About();
              }));
            },
          ),
          // 注销按钮
          ListTile(
            leading: const Icon(FluentIcons.sign_out_24_regular),
            title: Text(isLoggedIn ? '注销' : '登录'),
            onTap: () async {
              if (isLoggedIn) {
                _logout(); // 调用注销函数
              } else {
                // 如果未登录，跳转到登录页面,登录成功拿到登录成功的结果true
                bool result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserLogin()),
                );
                //如果登录成功，就刷新当前页面
                if (result == true) {
                  _loadUserInfo();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  // 注销函数
  void _logout() async {
    final authStatusProvider =
        Provider.of<AuthStatusprovider>(context, listen: false);
    //调用logoutProvider函数，从数据库中删除信息，删除provider中的变量值
    await authStatusProvider.logoutProvider();
    //重新加载用户信息
    _loadUserInfo();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "注销成功！",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
  }

  //更换主题
  void _showThemeDialog(BuildContext context, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('选择主题'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _themes.map((themeName) {
              return ListTile(
                title: Text(themeName),
                onTap: () {
                  themeProvider.changeTheme(themeName, context); // 更改主题
                  Navigator.pop(context); // 关闭对话框
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
