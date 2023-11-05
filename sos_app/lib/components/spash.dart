import 'package:flutter/material.dart';
import 'package:sos_app/Login_screen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    // _navigatetopage();
  }

  _navigatetopage() async {
    await Future.delayed(Duration(milliseconds: 150), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
