// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/components/custom-textfeild.dart';
import 'package:sos_app/loginsetup/email%20auth/Login_screen.dart';
//import 'package:flutter/widgets.dart';

class forgotpasss extends StatefulWidget {
  const forgotpasss({super.key});

  @override
  State<forgotpasss> createState() => _forgotpasssState();
}

class _forgotpasssState extends State<forgotpasss> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent check your email'),
            );
          });

      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Forgot Password"),
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
                    'assests/logowotxt.png',
                    width: 315,
                    height: 315,
                  ),
                ),

                SizedBox(
                  height: 8,
                ),

                // welcome text
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Enter your email and we will send you a password reset link',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 18),

                //email
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: CustomTextField(
                    controller: emailController,
                    hint_text: 'Email',
                    isPassword: false,
                  ),
                ),

                SizedBox(
                  height: 18,
                ),

                GestureDetector(
                  //onTap: ,
                  onTap: () {
                    passwordReset();
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
                        "Reset Password",
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
