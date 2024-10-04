import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/providers/userinfoProvider.dart';

class PersonalPageDemo extends StatefulWidget {
  const PersonalPageDemo({super.key});

  @override
  State<PersonalPageDemo> createState() => _PersonalPageDemoState();
}

class _PersonalPageDemoState extends State<PersonalPageDemo> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController(text: "*************");
  final TextEditingController _birthdayController = TextEditingController();
  String? _selectedGender;
  bool _isEditing = false; // 控制是否处于编辑模式
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    final userInfoProvider =
        Provider.of<UserInfoProvider>(context, listen: false);
    await userInfoProvider.fetchUserInfoProvider();
    setState(() {
      _emailController.text = userInfoProvider.userInfo!.email;
      _phoneController.text = userInfoProvider.userInfo!.phoneNumber;
      _usernameController.text = userInfoProvider.userInfo!.username;
      _birthdayController.text = userInfoProvider.userInfo!.birthday;
      _selectedGender = userInfoProvider.userInfo!.gender;
    });
  }

  void _saveUserInfo() {
    //数据库操作

    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfoProvider = Provider.of<UserInfoProvider>(context);
    final userInfo = userInfoProvider.userInfo;
    final username = userInfo?.username ?? "";
    final avatar = userInfo?.avatar ?? "";
    final bio = userInfo?.bio ?? "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("个人主页"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(avatar),
                ),
                const SizedBox(height: 10),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(bio,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal)),
                // 添加边距
                const SizedBox(height: 20),
                _buildTextInputField(
                    label: "用户名:", controller: _usernameController),
                const SizedBox(height: 10),
                _buildTextInputField(
                    label: "密码:",
                    controller: _passwordController,
                    isPassword: true),
                const SizedBox(height: 10),
                _buildTextInputField(
                    label: "邮箱:", controller: _emailController),
                const SizedBox(height: 10),
                _buildGenderSelector(),
                const SizedBox(
                  height: 20,
                ),
                _buildTextInputField(
                    label: "电话:", controller: _phoneController),
                const SizedBox(height: 10),
                _buildTextInputField(
                    label: "生日:", controller: _birthdayController),
                const SizedBox(height: 20),
                // 添加 编辑 & 保存按钮
                SizedBox(
                  width: double.infinity, // 使按钮占据整个宽度
                  child: ElevatedButton(
                    onPressed: _isEditing
                        ? _saveUserInfo
                        : () {
                            setState(() {
                              _isEditing = true; // 切换到编辑模式
                            });
                          },
                    child: Text(_isEditing ? '保存' : '编辑'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextInputField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Row(
      children: [
        Text(
          '$label ',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        // TextField 文字框
        Expanded(
          child: TextField(
            controller: controller,
            enabled: _isEditing,
            obscureText: isPassword, // 如果是密码，输入新密码的时候会变成*号
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  // 创建性别选择器
  Widget _buildGenderSelector() {
    return Row(
      children: [
        const Text(
          '性别: ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              if (_isEditing) {
                final selectedGender = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('选择性别'),
                      children: ['男', '女'].map((String gender) {
                        return SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, gender);
                          },
                          child: Text(gender),
                        );
                      }).toList(),
                    );
                  },
                );
                if (selectedGender != null) {
                  setState(() {
                    _selectedGender = selectedGender;
                  });
                }
              }
            },
            child: AbsorbPointer(
              child: TextField(
                controller: TextEditingController(text: _selectedGender),
                enabled: _isEditing, // 始终禁用，点击通过 GestureDetector 控制
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
