import 'package:flutter/material.dart';

void ggShowSnackBar(
  BuildContext context, {
  required String content,
  Color? color = Colors.red,
  SnackBarAction? action, 
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: color,
      action: action,
    ),
  );
}
