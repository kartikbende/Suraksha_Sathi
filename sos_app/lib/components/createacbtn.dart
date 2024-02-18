import 'package:flutter/material.dart';
import 'package:sos_app/pages/bottomnavbar.dart';

class createacbtn extends StatelessWidget {
  const createacbtn({super.key, required Null Function() onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: ,
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => bottomnavbar()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFD8080),
                Color(0xFFFB8580),
                Color(0xFFFBD079),
              ]),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
