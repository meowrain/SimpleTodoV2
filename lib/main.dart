import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_app/home/home.dart';
import 'package:todo_app/theme/themeProvider.dart';
import 'package:todo_app/todolist/models/todo_databse.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // 确保Flutter绑定已初始化
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化Todo数据库
  await TodoDatabse().initialize();
  // 运行应用程序，使用MultiProvider来提供依赖
  runApp(MultiProvider(
    providers: [
      // 提供TodoDatabase实例
      ChangeNotifierProvider<TodoDatabse>(create: (_) => TodoDatabse()),
      // 提供ThemeProvider实例
      ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
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
            theme: FlexThemeData.light(
              scheme: FlexScheme.materialBaseline,
              surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
              blendLevel: 7,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 10,
                blendOnColors: false,
                useM2StyleDividerInM3: true,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              swapLegacyOnMaterial3: true,
              fontFamily: GoogleFonts.notoSans().fontFamily,
              // To use the playground font, add GoogleFonts package and uncomment
              // fontFamily: GoogleFonts.notoSans().fontFamily,
            ),
            darkTheme: FlexThemeData.dark(
              scheme: FlexScheme.materialBaseline,
              surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
              blendLevel: 13,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 20,
                useM2StyleDividerInM3: true,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              swapLegacyOnMaterial3: true,
              fontFamily: GoogleFonts.notoSans().fontFamily,
              // To use the Playground font, add GoogleFonts package and uncomment
              // fontFamily: GoogleFonts.notoSans().fontFamily,
            ),
            themeMode: themeProvider.themeMode,
          );
        },
      ),
    );
  }
}
