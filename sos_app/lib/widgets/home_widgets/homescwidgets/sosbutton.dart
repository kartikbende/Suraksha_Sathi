import 'package:background_sms/background_sms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sos_app/db/dbservices.dart';
import 'package:sos_app/models/contactsm.dart';

import '../../../provider/auth_provider.dart';

class SOSbtn extends StatefulWidget {
  const SOSbtn({super.key});

  @override
  State<SOSbtn> createState() => _SOSbtnState();
}

class _SOSbtnState extends State<SOSbtn> {
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

  @override
  void initState() {
    super.initState();
    _getPermission();
    _getCurrentLocation();
    _handleLocationPermission();
  }

  showmodelforsos(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.4,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SEND YOUR CUURENT LOCATION IMMEDIATELY TO YOU EMERGENCY CONTACTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                if (_curentPosition != null) Text(_curentAddress!),
                getlocationbtnsos(),
                SizedBox(height: 10),
                sendalertbtnsos(),
              ],
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
        );
      },
    );
  }

  // showmodelforsos(
  //   BuildContext context,
  // ) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height / 1.4,
  //         child: Padding(
  //           padding: const EdgeInsets.all(14.0),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 "Send Your Current Location to Emergency Contacts",
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(fontSize: 20),
  //               ),
  //               SizedBox(height: 10),
  //               getlocationbtnsos(),
  //               SizedBox(height: 10),
  //               sendalertbtnsos(),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  GestureDetector sendalertbtnsos() {
    return GestureDetector(
      //onTap: ,
      onTap: () async {
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
          String helpme = "Help me";
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
            "Send Alert",
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

  GestureDetector getlocationbtnsos() {
    return GestureDetector(
      //onTap: ,
      onTap: () async {
        _getCurrentLocation();

        print("location cptred");
        print(_curentPosition);
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
            "Get Location",
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 200,
          width: 800,
          padding: EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // onPressed: () {},

              TextButton(
                onPressed: () {
                  showmodelforsos(context);
                  _handleLocationPermission();
                },
                child: Image.asset(
                  'assests/sosbtn.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
