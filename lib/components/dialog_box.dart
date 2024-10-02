import 'package:flutter/material.dart';
import 'package:todo_app/components/button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onSave;
  final void Function()? onCancel;
  const DialogBox(
      {super.key, required this.controller, this.onSave, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                label: Text("Add Todo"),
                border: OutlineInputBorder(),
                hintText: "Add a new Todo",
              ),
            ),
            Row(
              children: [
                TodoButton(onPressed: onSave ?? () {}, text: "Add"),
                const SizedBox(
                  width: 8,
                ),
                TodoButton(onPressed: onCancel ?? () {}, text: "Cancel")
              ],
            )
          ],
        ),
      ),
    );
  }
}
