import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_app/config/config_init.dart';
import 'package:todo_app/src/providers/authStatusProvider.dart';
import 'package:todo_app/src/providers/todoProvider.dart';
import 'package:todo_app/src/providers/userinfoProvider.dart';
import 'package:todo_app/src/theme/theme_manager.dart';
import 'package:todo_app/src/views/home/home.dart';
import 'package:todo_app/src/providers/themeProvider.dart';
import 'package:todo_app/src/utils/initial_localdb.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // 确保Flutter绑定已初始化
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化Todo数据库
  await LocalDb().initialize();
  //初始化配置管理器，调用init函数
  await ConfigManager().init();
  // 运行应用程序，使用MultiProvider来提供依赖
  runApp(MultiProvider(
    providers: [
      // 提供TodoDatabase实例
      ChangeNotifierProvider<Todoprovider>(create: (_) => Todoprovider()),
      // 提供ThemeProvider实例
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      //提供UserInfoProvider实例
      ChangeNotifierProvider<UserInfoProvider>(
          create: (_) => UserInfoProvider()),
      //提供AuthStatusProvider实例
      ChangeNotifierProvider<AuthStatusprovider>(
          create: (_) => AuthStatusprovider())
    ],
    // TodoApp作为子部件
    child: const TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      // 使用Consumer监听ThemeProvider的变化
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            // 禁用调试模式下的检查模式横幅
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
            theme: ThemeManager.LightTheme.midnight,
            darkTheme: ThemeManager.DarkTheme.midnight,
            themeMode: themeProvider.themeMode,
          );
        },
      ),
    );
  }
}
