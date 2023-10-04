import 'package:flutter/material.dart';
import 'package:sos_app/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [custom_app_bar()]),
    ));
  }
}
