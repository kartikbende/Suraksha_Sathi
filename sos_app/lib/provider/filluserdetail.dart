import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_app/models/usermodel.dart';
import 'package:sos_app/pages/bottomnavbar.dart';
import 'package:sos_app/provider/auth_provider.dart';
import 'package:sos_app/utils/snckkbar.dart';

class filldetailsuser extends StatefulWidget {
  const filldetailsuser({super.key});

  @override
  State<filldetailsuser> createState() => _filldetailsuserState();
}

class _filldetailsuserState extends State<filldetailsuser> {
  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController addiinfoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController guardian1controller = TextEditingController();
  TextEditingController guardian2controller = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    addiinfoController.dispose();
    guardian1controller.dispose();
    guardian2controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<authprov>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 5.0),
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset(
                            'assests/sos_logo.png',
                            width: 375,
                            height: 375,
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        // welcome text
                        Padding(
                          padding: const EdgeInsets.only(left: 9, right: 9),
                          child: Text(
                            'Welcome to Suraksha Sathi Enter your details to become an user',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {},
                        //   child: image == null
                        //       ? const CircleAvatar(
                        //           backgroundColor: Colors.deepOrange,
                        //           radius: 50,
                        //           child: Icon(
                        //             Icons.account_circle,
                        //             size: 50,
                        //             color: Colors.white,
                        //           ),
                        //         )
                        //       : CircleAvatar(
                        //           backgroundImage: FileImage(image!),
                        //           radius: 50,
                        //         ),
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              // name
                              TextField(
                                  hintText: "Enter Your Name",
                                  icon: Icons.account_circle,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: nameController),
                              //emaiol
                              TextField(
                                  hintText: 'Enter Your Email',
                                  icon: Icons.email,
                                  inputType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  controller: emailController),
                              //Guardian1
                              TextField(
                                  hintText: 'Enter Guardian1 Email',
                                  icon: Icons.email,
                                  inputType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  controller: guardian1controller),
                              //Guardian2
                              TextField(
                                  hintText: 'Enter Guardian2 Email',
                                  icon: Icons.email,
                                  inputType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  controller: guardian2controller),
                              // additional information
                              TextField(
                                  hintText:
                                      "Enter Your Medical Conditions along with Blood Group.",
                                  icon: Icons.edit,
                                  inputType: TextInputType.name,
                                  maxLines: 3,
                                  controller: addiinfoController),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        filluserbtn(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  GestureDetector filluserbtn() {
    return GestureDetector(
      //onTap: ,
      onTap: () {
        storeData();
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
            "Continue",
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

  Widget TextField(
      {required String hintText,
      required IconData icon,
      required TextInputType inputType,
      required int maxLines,
      required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.indigo[600],
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepOrange.shade700,
            ),
            child: Icon(
              icon,
              size: 25,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.deepOrange.shade100,
          filled: true,
        ),
      ),
    );
  }

  //store the data
  void storeData() async {
    final ap = Provider.of<authprov>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      bio: addiinfoController.text.trim(),
      createdAt: "",
      PhoneNumber: "",
      uid: "",
      guardian1: guardian1controller.text.trim(),
      guardian2: guardian2controller.text.trim(),
    );
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String bio = addiinfoController.text.trim();
    String guardian1 = guardian1controller.text.trim();
    String guardian2 = guardian2controller.text.trim();
    if (name == "" &&
        email == "" &&
        bio == "" &&
        guardian1 == "" &&
        guardian2 == "") {
      showSnckBar(context, "Enter all the details");
    } else {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => bottomnavbar(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    }
    // if (condition) {

    // } else {

    // } condition to add the profile picture wala ignore
  }
}
