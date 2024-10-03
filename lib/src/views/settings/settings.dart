import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/providers/userinfoProvider.dart';
import 'package:todo_app/src/views/about/about.dart';
import 'package:todo_app/src/views/privacy_policy/privacy_policy.dart';
import 'package:todo_app/src/providers/themeProvider.dart';
import 'package:todo_app/src/views/user/profile.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notificationsEnabled = true;
  // 每次打开的时候调用一次，更新userInfoProvider全局状态
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    final userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    await userInfoProvider.fetchUserInfoProvider();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userInfoProvider = Provider.of<UserInfoProvider>(context);

    // 从 userInfoProvider 提取 userInfo,如果为空，就返回？？后面的
    final username = userInfoProvider.userInfo?.username ?? "未登录";
    final avatar = userInfoProvider.userInfo?.avatar ?? '';
    final email = userInfoProvider.userInfo?.email ?? '';

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
                      : Icon(size: 100.0, FluentIcons.person_circle_28_regular),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    username,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(FluentIcons.person_24_regular),
            title: const Text('账户'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalProfile()));
            },
          ),
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
          SwitchListTile(
            secondary: const Icon(FluentIcons.alert_24_regular),
            title: const Text('通知'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(FluentIcons.dark_theme_24_regular),
            title: const Text('夜间模式'),
            value: themeProvider.isDarkMode(context),
            onChanged: (bool value) {
              setState(() {
                themeProvider.toggleTheme(value, context);
              });
            },
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
        ],
      ),
    );
  }
}
