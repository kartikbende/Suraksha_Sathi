import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sos_app/components/LocaleString.dart';
import 'package:sos_app/pages/bottomnavbar.dart';
import 'package:sos_app/provider/auth_provider.dart';
import 'package:sos_app/provider/registerscreen.dart';
import 'package:sos_app/utils/background_services.dart';

//import 'package:sos_app/pages/home_screen.dart';
//import 'package:sos_app/widgets/langselect.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => authprov(),
        ),
      ],
      child: GetMaterialApp(
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
        home: Center(
          child: AnimatedSplashScreen.withScreenFunction(
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
              // final ap = Provider.of<authprov>(context, listen: true);
              await Future.delayed(Duration(milliseconds: 150), () {});
              if (FirebaseAuth.instance.currentUser != null) {
                // add to the if statement && ap.isSignedIn == true
                // If user is signed in, navigate to bottomnavbar
                return bottomnavbar();
              } else {
                // If user is not signed in and additional condition is not met, navigate to regscreen
                return regscreen();
              }
            },
            splashTransition: SplashTransition.scaleTransition,
          ),
        ),
      ),
    );
  }
}
