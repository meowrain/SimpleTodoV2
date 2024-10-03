import 'package:flutter/material.dart';

// 定义一个有状态的组件 PersonalProfile，用于显示和编辑个人信息
class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  // 控制器用于管理文本字段的内容
  final TextEditingController _emailController =
      TextEditingController(text: 'user@example.com');
  final TextEditingController _phoneController =
      TextEditingController(text: '+1234567890');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("个人信息"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 显示用户头像
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage('assets/images/user.jpg'), // 你可以替换成用户的头像
              ),
            ),
            const SizedBox(height: 20),
            // 显示用户名
            const Center(
              child: Text(
                '用户名',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 显示邮箱信息
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '邮箱',
              ),
              enabled: false, // 禁用编辑
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            // 显示电话信息
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: '电话',
              ),
              enabled: false, // 禁用编辑
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            // 编辑按钮，点击后弹出编辑对话框
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _showEditDialog();
                  },
                  child: const Text(
                    '编辑个人信息',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 显示编辑对话框的方法
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // 创建新的控制器用于编辑
        final TextEditingController _editEmailController =
            TextEditingController(text: _emailController.text);
        final TextEditingController _editPhoneController =
            TextEditingController(text: _phoneController.text);

        return AlertDialog(
          title: const Text('编辑个人信息'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 编辑邮箱
              TextField(
                controller: _editEmailController,
                decoration: const InputDecoration(
                  labelText: '邮箱',
                ),
              ),
              const SizedBox(height: 10),
              // 编辑电话
              TextField(
                controller: _editPhoneController,
                decoration: const InputDecoration(
                  labelText: '电话',
                ),
              ),
            ],
          ),
          actions: [
            // 取消按钮，关闭对话框
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            // 保存按钮，保存编辑内容并关闭对话框
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _emailController.text = _editEmailController.text;
                  _phoneController.text = _editPhoneController.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
  }
}
