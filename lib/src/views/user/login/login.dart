import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/api/user/user_api.dart';
import 'package:todo_app/src/views/user/register/register.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController _username_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  void _loginHandler() async {
    bool isSuccess = await login(
        username: _username_controller.text,
        password: _password_controller.text);
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "登录成功！",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
      // 跳出当前路由
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "登录失败",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // 使用 SingleChildScrollView 包裹 Column
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Icon(
                  FluentIcons.lock_closed_20_regular,
                  size: 90,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "欢迎使用Pure Todo!",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _username_controller,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide()),
                        hintText: "用户名"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _password_controller,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide()),
                        hintText: "密码"),
                    obscureText: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserRegister()));
                          },
                          child: Text("注册")),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("忘记密码？"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50, // 设置适中的高度
                    child: ElevatedButton(
                      onPressed: () {
                        _loginHandler();
                      },
                      child: const Text(
                        "登录",
                        style: TextStyle(fontSize: 17), // 文字大一点儿
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

//释放资源，防止内存泄漏
  @override
  void dispose() {
    _username_controller.dispose();
    _password_controller.dispose();
    super.dispose();
  }
}
