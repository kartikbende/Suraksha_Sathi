import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sos_app/widgets/home_widgets/homescwidgets/CustomCarousel.dart';
import 'package:sos_app/widgets/home_widgets/homescwidgets/custom_app_bar.dart';
import 'package:sos_app/widgets/home_widgets/homescwidgets/emrgency.dart';
import 'package:sos_app/widgets/home_widgets/homescwidgets/nearcomo.dart';
import 'package:sos_app/widgets/home_widgets/homescwidgets/sosbutton.dart';

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 800.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // Align children horizontally
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Evenly spaced children
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: custom_app_bar(
                      quoteeIndex: qIndex,
                      onTap: getRandomQuote(),
                    ),
                  ),
                  CustomCarousel(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Emergency",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Emergency(),
                  SOSbtn(),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Nearest Commodities",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  nearcomodity(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
