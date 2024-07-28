import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final bool useTitleColor;
  final List<Widget> actions;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
    this.useTitleColor = false, // Default to false if not specified
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: useTitleColor ? AppColors.appColorRed : null),
      ),
      content: content,
      actions: actions,
    );
  }
}
