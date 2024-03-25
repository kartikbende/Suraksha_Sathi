import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sos_app/loginsetup/phone%20auth/loginphone.dart';
import 'package:sos_app/pages/bottomnavbar.dart';
import 'package:sos_app/provider/filluserdetail.dart';

class otpverify extends StatefulWidget {
  final String verificationId;
  const otpverify({Key? key, required this.verificationId});

  @override
  State<otpverify> createState() => otpverifyState();
}

TextEditingController otpController = TextEditingController();

class otpverifyState extends State<otpverify> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign In with Phone"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 550.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0,
                ),
                //logo
                Center(
                  child: Image.asset(
                    'assests/OTPPN.png',
                    width: 250,
                    height: 250,
                  ),
                ),

                SizedBox(
                  height: 8,
                ),

                // welcome text
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Text(
                      'Enter the OTP sent to you',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                SizedBox(height: 18),

                //OTP

                Padding(
                  padding: const EdgeInsets.only(left: 27, right: 27),
                  child: Pinput(
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.deepOrange.shade700)),
                        textStyle: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600)),
                    controller: otpController,
                  ),
                ),

                SizedBox(
                  height: 18,
                ),

                GestureDetector(
                  //onTap: ,
                  onTap: () {
                    Future optVerify() async {
                      String OTP = otpController.text.trim();
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: OTP);
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithCredential(credential);
                        if (userCredential.user != null) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => bottomnavbar()),
                          );
                          Future<bool> checkExistingUser() async {
                            DocumentSnapshot snapshot = await FirebaseFirestore
                                .instance
                                .collection("users")
                                .doc(phoneno)
                                .get();
                            if (snapshot.exists) {
                              print("old");
                              return true;
                            } else {
                              print("new");
                              return false;
                            }
                          }

                          checkExistingUser().then((value) async {
                            if (value == true) {
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          filldetailsuser())));
                            }
                          });
                        }
                      } on FirebaseAuthException catch (ex) {
                        log(ex.code.toString());
                      }
                    }

                    optVerify();
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
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
