import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('隐私协议'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '隐私协议',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '感谢您选择使用我们的待办事项应用（以下简称“应用”）。我们非常重视您的隐私，并致力于保护您的个人信息。本隐私协议（“协议”）旨在告知您有关我们在您使用本应用时如何收集、使用、存储、共享以及保护您的个人信息。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '1. 收集的信息',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '当您使用我们的应用时，我们可能会收集以下类型的信息：\n\n'
              '日志数据：当您使用应用时，系统可能会自动记录某些信息，例如设备信息、应用活动和崩溃报告。\n'
              '用户生成的内容：您创建的任务列表、笔记和其他内容。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '2. 使用信息的方式',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '我们承诺仅在必要时使用您的个人信息，并且仅用于以下目的：\n\n'
              '提供和支持我们的服务；\n'
              '改进应用的功能和性能；\n'
              '向您发送重要通知，例如关于应用更新的通知。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '3. 数据共享',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '除非得到您的明确同意，我们不会与任何第三方共享您的个人信息。但是，我们可能会与服务提供商共享信息，以帮助我们提供和支持服务。这些服务提供商只能根据我们的指示行事，并且必须对您的信息保密。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '4. 安全性',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '我们采取了适当的安全措施来防止您的信息丢失、被滥用或被未经授权的访问、披露、更改或销毁。然而，请记住，没有一种互联网传输方法是完全安全的。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '5. 用户的选择与控制',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '您可以选择是否接收来自我们的任何通知。您可以在应用设置中管理您的通知偏好。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '6. 第三方链接和服务',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '我们的应用可能包含指向第三方网站或服务的链接。请注意，这些第三方网站或服务不属于我们的控制范围之内，因此本隐私协议不适用于此类第三方的行为。我们建议您查看您访问的每一个第三方网站或服务的隐私政策。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '7. 隐私政策的更新',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '我们保留在必要时更新本隐私政策的权利。如果我们在未来做出重大更改，我们将在应用内发布通知。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '8. 联系我们',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '如果您有关于隐私政策的问题或意见，请通过以下方式与我们联系：\n\n'
              '电子邮件：[您的电子邮件地址]\n'
              '网站：[您的网站地址]\n'
              '应用内反馈功能',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '9. 法律适用',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '本协议受中华人民共和国法律管辖，并按其解释。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '最后更新日期：[填写最后更新日期]',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
