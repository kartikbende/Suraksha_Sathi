import 'package:flutter/material.dart';
import 'package:sos_app/components/custom-textfeild.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              hint_text: "Enter name",
            ),
          ],
        ),
      )),
    );
  }
}
