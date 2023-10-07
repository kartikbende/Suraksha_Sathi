import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sos_app/widgets/home_widgets/CustomCarousel.dart';
import 'package:sos_app/widgets/home_widgets/custom_app_bar.dart';
import 'package:sos_app/widgets/home_widgets/emrgency.dart';
import 'package:sos_app/widgets/home_widgets/sosbutton.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //const HomeScreen({super.key});
  int qIndex = 1;

  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
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
                    CustomCarousel(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Emergeny",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Emergency(),
                    SOSbtn(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.start,
                        "Neareast Comodities",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ))));
  }
}
