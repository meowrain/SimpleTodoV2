import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: const NetworkImage(
                        'https://meowrain.cn/upload/2024/06/IMG_20240511_124707_183.jpg'),
                    onBackgroundImageError: (error, stackTrace) {
                      // Handle image loading error
                      print('Image loading error: $error');
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'MeowRain',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          // const Divider(),
          ListTile(
            leading: const Icon(FluentIcons.person_24_regular),
            title: const Text('Account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalProfile()));
              // Navigate to account settings
            },
          ),
          ListTile(
            leading: const Icon(FluentIcons.lock_closed_24_regular),
            title: const Text('Privacy'),
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
            title: const Text('Notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            secondary: const Icon(FluentIcons.dark_theme_24_regular),
            title: const Text('Dark Mode'),
            value: themeProvider.isDarkMode(context),
            onChanged: (bool value) {
              setState(() {
                themeProvider.toggleTheme(value, context);
              });
            },
          ),
          ListTile(
            leading: const Icon(FluentIcons.info_24_regular),
            title: const Text('About'),
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
