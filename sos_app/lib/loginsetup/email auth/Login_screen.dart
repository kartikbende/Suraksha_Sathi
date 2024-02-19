import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sos_app/components/custom-textfeild.dart';
import 'package:sos_app/components/square_tile.dart';
import 'package:sos_app/loginsetup/email%20auth/forgot_pass.dart';
import 'package:sos_app/loginsetup/email%20auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sos_app/pages/bottomnavbar.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // sign in user method
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      log("Please fill all the fields!");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => bottomnavbar()),
          );
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 800.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 0,
                ),
                //logo
                Center(
                  child: Image.asset(
                    'assests/sos_logo.png',
                    width: 300,
                    height: 300,
                  ),
                ),

                SizedBox(
                  height: 8,
                ),

                // welcome text
                Text(
                  'Welcome to Suraksha Sathi ! Your safety is our top priority. Please log in to access our services.',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
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

                SizedBox(height: 8),

                // PASSWORD
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: CustomTextField(
                    controller: passwordController,
                    hint_text: 'Password',
                    isPassword: true,
                  ),
                ),

                SizedBox(
                  height: 8,
                ),

                //FORGOT PASS WORD ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onLongPress: () => Text(
                          "Forgot Password",
                          style: TextStyle(color: Colors.blue[600]),
                        ),
                        onTap: () {
                          // Navigate to the new screen when the text is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => forgotpasss()),
                          );
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                //my button
                GestureDetector(
                  //onTap: ,
                  onTap: () {
                    login();
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

                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'assests/google.png'),

                    // apple button
                    // SquareTile(imagePath: 'assests/apple.png')
                  ],
                ),

                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the new screen when the text is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: Text(
                        'Signup now!!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue[600],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
