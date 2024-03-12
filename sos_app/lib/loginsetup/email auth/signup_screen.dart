import 'dart:developer';

//import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/components/custom-textfeild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cpasswordController.text.trim();

    if (email == "" || password == "" || cPassword == "") {
      log("Please fill all the details!");
    } else if (password != cPassword) {
      log("Passwords do not match!");
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create an account"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(
                    height: 0,
                  ),
                  //logo
                  Center(
                    child: Image.asset(
                      'assests/sos_logo.png',
                      width: 350,
                      height: 350,
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),

                  // welcome text
                  Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Text(
                      'Welcome to Suraksha Sathi ! Create your account here',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
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

                  SizedBox(height: 15),

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
                    height: 15,
                  ),

                  //CONFIRM PASSWORD
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: CustomTextField(
                      controller: cpasswordController,
                      hint_text: 'Confirm Password',
                      isPassword: true,
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    //onTap: ,
                    onTap: () {
                      createAccount();
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
