import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

                  //CONFIRM PASSWORD
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: CustomTextField(
                      controller: cpasswordController,
                      hint_text: 'Password',
                      isPassword: true,
                    ),
                  ),

                  SizedBox(
                    height: 8,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      createAccount();
                    },
                    color: Color.fromARGB(246, 251, 115, 31),
                    child: Text("Create Account"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
