import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Login_screen.dart';
import 'package:sos_app/components/LocaleString.dart';
//import 'package:sos_app/Login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:sos_app/widgets/langselect.dart';

void main() {
  runApp(const MyApp());
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
            return LoginScreen();
          },
          splashTransition: SplashTransition.scaleTransition,
        ));
  }
}
