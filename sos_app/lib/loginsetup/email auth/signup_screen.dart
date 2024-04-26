import 'dart:developer';

//import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/components/CustomTextFeild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    phonenumberController.dispose();
    super.dispose();
  }

  addUserDetails(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
  ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'phone number': phoneNumber,
    });
  }

  Future createAccount() async {
    //create user
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

        await userCredential.user!.sendEmailVerification();

        addUserDetails(
          firstnameController.text.trim(),
          lastnameController.text.trim(),
          emailController.text.trim(),
          "+91" + phonenumberController.text.trim(),
        );
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  // Future addUserDetails(
  //   String firstName,
  //   String lastName,
  //   String email,
  //   String phoneNumber,
  // ) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'first name': firstName,
  //     'last name': lastName,
  //     'email': email,
  //     'phone number': phoneNumber,
  //   });
  // }

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
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  //logo
                  Center(
                    child: Image.asset(
                      'assests/logowotxt.png',
                      width: 220,
                      height: 220,
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
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15),
                  //First Name
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: CustomTextField(
                      controller: firstnameController,
                      hint_text: 'First Name',
                      isPassword: false,
                    ),
                  ),

                  SizedBox(height: 15),

                  //Last Name
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: CustomTextField(
                      controller: lastnameController,
                      hint_text: 'Last Name',
                      isPassword: false,
                    ),
                  ),

                  SizedBox(height: 15),

                  //Phone number
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: CustomTextField(
                      controller: phonenumberController,
                      hint_text: 'Phone Number',
                      isPassword: false,
                    ),
                  ),

                  SizedBox(height: 15),

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
                    onTap: () async {
                      await createAccount();
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
