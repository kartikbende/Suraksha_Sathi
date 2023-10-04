import 'package:flutter/material.dart';
import 'package:sos_app/utils/quotes.dart';

class custom_app_bar extends StatelessWidget {
  const custom_app_bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       child padding(context),
        child: Text(
      quotee[0],
      style: TextStyle(fontSize: 22),
    ));
  }
}
