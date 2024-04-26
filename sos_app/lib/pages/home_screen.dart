import 'dart:math';

import 'package:background_sms/background_sms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'package:sos_app/db/dbservices.dart';
import 'package:sos_app/models/contactsm.dart';
import 'package:sos_app/provider/auth_provider.dart';
import 'package:sos_app/provider/registerscreen.dart';
import 'package:sos_app/widgets/home_widgets/homescwidgets/CustomCarousel.dart';
//import 'package:sos_app/widgets/home_widgets/homescwidgets/custom_app_bar.dart';
import 'package:sos_app/widgets/home_widgets/homescwidgets/emrgency.dart';
import 'package:sos_app/widgets/home_widgets/homescwidgets/nearcomo.dart';
import 'package:sos_app/widgets/home_widgets/homescwidgets/sosbutton.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //const HomeScreen({super.key});
  int qIndex = 1;

  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => regscreen()),
    );
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;
  String name = FirebaseAuth.instance.currentUser!.uid.toString();
  String names = FirebaseAuth.instance.currentUser!.displayName.toString();
  String naam = " ";
  String bioo = " ";
  Position? _curentPosition;
  String? _curentAddress = " ";
  LocationPermission? permission;
  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(
    String phoneNumber,
    String message,
  ) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
      Fluttertoast.showToast(msg: "send");
    } else {
      Fluttertoast.showToast(msg: "failed");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentLocation() async {
    bool isLocationPermissionGranted = await _requestLocationPermission();
    if (isLocationPermissionGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final ap = Provider.of<authprov>(context, listen: false);
      String? namee = await ap.getCurrentUserName(uid);
      String? bio = await ap.getCurrentUserbio(uid);

      setState(() {
        naam = namee!;
        bioo = bio!;
        _curentPosition = position;
      });
    } else {
      print('Location permission denied.');
    }
  }

  Future<bool> _requestLocationPermission() async {
    PermissionStatus permission = await Permission.location.request();
    return permission == PermissionStatus.granted;
  }

  getAndSendSMS() async {
    String recipients = "";
    int i = 1;
    List<TContact> contactList = await DatabaseHelper().getContactList();
    for (TContact contact in contactList) {
      recipients += contact.number;
      if (i != contactList.length) {
        recipients += ";";
        i++;
      }
    }
    print(contactList.length);
    if (contactList.isEmpty) {
      Fluttertoast.showToast(msg: "emergency contact is empty");
    } else {
      String messageBody =
          "https://maps.google.com/?daddr=${_curentPosition!.latitude},${_curentPosition!.longitude}";

      if (await _isPermissionGranted()) {
        contactList.forEach((element) {
          _sendSms("${element.number}",
              "i am $naam and $bioo i am in trouble $messageBody");
          // _sendSms(
          //     "+919137503303", " Help me i am in trouble $messageBody");
        });
        print("msg sent");
      } else {
        Fluttertoast.showToast(msg: "something wrong");
      }
    }
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
    _getPermission();
    _getCurrentLocation();

    // shake feature
    ShakeDetector.autoStart(
      onPhoneShake: () {
        getAndSendSMS();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Shake!'),
        //   ),
        // );
        // Do stuff on phone shake
      },
      minimumShakeCount: 2,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 980.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // Align children horizontally
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Evenly spaced children
                children: [
                  _homepageappbar(),
                  CustomCarousel(),
                  Emergencytxt(),
                  Emergency(),
                  SOSbtn(),
                  nearestcomoditytxt(),
                  SizedBox(
                    height: 2,
                  ),
                  nearcomodity(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Align _homepageappbar() {
    return Align(
      alignment: Alignment.center,
      child: AppBar(
        title: Text("Suraksha Sathi"),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
    );
  }

  Padding Emergencytxt() {
    return const Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        "Emergency",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Center nearestcomoditytxt() {
    return const Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Text(
          "Nearest Comodity",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
