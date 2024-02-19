import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/loginsetup/email%20auth/Login_screen.dart';
import 'package:sos_app/components/LocaleString.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sos_app/pages/bottomnavbar.dart';
import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: LocaleString(),
        locale: Locale('en', 'US'),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.firaSansTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen.withScreenFunction(
          animationDuration: Duration(milliseconds: 600),
          splash: SafeArea(
            child: Container(
              height: 800,
              width: 800,
              padding: EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 9,
                    child: Image.asset(
                      'assests/sos_logo.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          screenFunction: () async {
            await Future.delayed(Duration(milliseconds: 150), () {});
            return (FirebaseAuth.instance.currentUser != null)
                ? bottomnavbar()
                : LoginScreen();
          },
          splashTransition: SplashTransition.scaleTransition,
        ));
  }
}
