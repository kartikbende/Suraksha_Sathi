import 'package:flutter/material.dart';
import 'package:sos_app/utils/quotes.dart';

// ignore: must_be_immutable
class custom_app_bar extends StatelessWidget {
  //const custom_app_bar({super.key});
  Function? onTap;
  int? quoteeIndex;
  custom_app_bar({this.onTap, this.quoteeIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        child: Text(
          quotee[quoteeIndex!],
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
