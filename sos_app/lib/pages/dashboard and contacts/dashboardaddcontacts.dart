import 'package:flutter/material.dart';
import 'package:sos_app/pages/dashboard%20and%20contacts/dashboard.dart';

class AddContactsPage extends StatelessWidget {
  const AddContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Column(
            children: [
              addcontactbtn(context),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector addcontactbtn(BuildContext context) {
    return GestureDetector(
      //onTap: ,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => dashboard()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFD8080),
              Color(0xFFFB8580),
              Color(0xFFFBD079),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Add Trusted Contacts",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
