import 'package:flutter/material.dart';

class TodoButton extends StatelessWidget {
  final String text;
  void Function() onPressed;
  TodoButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed, child: Text(text));
  }
}
