import 'package:flutter/material.dart';

void showSnckBar(
  BuildContext context,
  String content,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
