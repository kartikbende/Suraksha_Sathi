import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:sos_app/pages/bottomnavbar.dart';
import 'package:sos_app/provider/auth_provider.dart';
import 'package:sos_app/provider/filluserdetail.dart';
import 'package:sos_app/utils/snckkbar.dart';

class otppverify extends StatefulWidget {
  final String verificationId;
  const otppverify({super.key, required this.verificationId});

  @override
  State<otppverify> createState() => _otppverifyState();
}

// TextEditingController otpController = TextEditingController();
String OTP = "";
/*void optVerify(BuildContext context, String OTP) async {
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
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => bottomnavbar()),
                            );
                            Future<bool> checkExistingUser() async {
                              DocumentSnapshot snapshot =
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc()
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
                                    builder: (context) => filldetailsuser(),
                                  ),
                                );
                              }
                            });
                          }
                        } on FirebaseAuthException catch (ex) {
                          log(ex.code.toString());
                        }
                      }  */

class _otppverifyState extends State<otppverify> {
  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<authprov>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 620.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),
                        ),
                        //logo
                        Center(
                          child: Image.asset(
                            'assests/OTP.png',
                            width: 300,
                            height: 300,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
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

                        const SizedBox(
                          height: 20,
                        ),

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
                                  border: Border.all(
                                      color: Colors.deepOrange.shade700),
                                ),
                                textStyle: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                              onCompleted: (value) {
                                setState(() {
                                  OTP = value;
                                });
                              }),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          //onTap: ,
                          onTap: () {
                            if (OTP != null) {
                              verifyOtp(context, OTP!);
                            } else {
                              showSnckBar(context, "Enter 6-Digit code");
                            }
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
                                ],
                              ),
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

                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't recieve any code",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 16),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                // Navigate to the new screen when the text is clicked
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => SignUpScreen()),
                                // );
                              },
                              child: Text(
                                'Resend New Code',
                                style: TextStyle(
                                  fontSize: 16,
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
              ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String OTP) {
    final ap = Provider.of<authprov>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      OTP: OTP,
      onSuccess: () {
        //check wether user exsist in db
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => bottomnavbar(),
                  ),
                  (route) => false);
            } else {
              //user nai hai naya banao
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => filldetailsuser(),
                  ),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}

// const otppverify({Key? key, required this.verificationId});
