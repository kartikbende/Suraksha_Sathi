import 'package:flutter/material.dart';

class SOSbtn extends StatelessWidget {
  const SOSbtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 200,
          width: 800,
          padding: EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Image.asset('assests/sosbtn.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
