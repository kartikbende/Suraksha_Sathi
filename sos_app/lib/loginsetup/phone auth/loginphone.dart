import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/components/custom-textfeild.dart';

class loginphone extends StatefulWidget {
  const loginphone({super.key});

  @override
  State<loginphone> createState() => _loginphoneState();
}

Country Selectedcountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "");

TextEditingController phonenumberController = TextEditingController();

Future sendOTP() async {
  //String phone = "+" + Selectedcountry.countryCode + phonenumberController.text.trim();
}

class _loginphoneState extends State<loginphone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Phone Login"),
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
                    'assests/OTP.png',
                    width: 280,
                    height: 280,
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                // welcome text
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    'Enter your Phone number and we will send you the OTP',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 20),

                //email
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: CustomTextField(
                    controller: phonenumberController,
                    hint_text: 'Enter your phone number',
                    isPassword: false,
                    preftx: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                bottomSheetHeight: 400,
                              ),
                              onSelect: (value) {
                                setState(() {
                                  Selectedcountry = value;
                                });
                              });
                        },
                        child: Text(
                          "${Selectedcountry.flagEmoji} + ${Selectedcountry.phoneCode}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                GestureDetector(
                  //onTap: ,
                  onTap: () {
                    sendOTP();
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
                        "Send OTP",
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
