import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sos_app/widgets/custom_app_bar.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  //const HomeScreen({super.key});
  int qIndex = 0;

  getRandomQuote() {
    Random random = Random();
    qIndex = random.nextInt(6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    custom_app_bar(
                      quoteeIndex: qIndex,
                      onTap: getRandomQuote(),
                    ),
                  ],
                ))));
  }
}
