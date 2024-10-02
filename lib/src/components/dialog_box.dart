import 'package:flutter/material.dart';
import 'package:todo_app/src/components/button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onSave;
  final void Function()? onCancel;
  const DialogBox(
      {super.key, required this.controller, this.onSave, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                label: Text("添加Todo"),
                border: OutlineInputBorder(),
                hintText: "添加一个新的待办事项",
              ),
            ),
            Row(
              children: [
                TodoButton(onPressed: onSave ?? () {}, text: "添加"),
                const SizedBox(
                  width: 8,
                ),
                TodoButton(onPressed: onCancel ?? () {}, text: "取消")
              ],
            )
          ],
        ),
      ),
    );
  }
}
