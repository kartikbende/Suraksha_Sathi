import 'package:flutter/material.dart';
import 'package:sos_app/components/custom-textfeild.dart';
import 'package:sos_app/components/mybtn.dart';
import 'package:sos_app/components/square_tile.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in user method
  void signuserin() {}
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

                //USERNAME
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: CustomTextField(
                    controller: usernameController,
                    hint_text: 'User Name',
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
                      Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                //my button
                Mybtn(
                  onTap: signuserin,
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

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'assests/apple.png')
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
                    const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
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
