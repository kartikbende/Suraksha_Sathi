import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sos_app/utils/snckkbar.dart';

class SOSbtn extends StatefulWidget {
  const SOSbtn({super.key});

  @override
  State<SOSbtn> createState() => _SOSbtnState();
}

class _SOSbtnState extends State<SOSbtn> {
  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;
  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    await BackgroundSms.sendMessage(
            phoneNumber: phoneNumber, message: message, simSlot: simSlot)
        .then(
      (SmsStatus status) {
        if (status == "sent") {
          Fluttertoast.showToast(msg: "Sent");
        } else {
          Fluttertoast.showToast(msg: "Failed");
        }
      },
    );
  }

  _getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Fluttertoast.showToast(msg: "Location Permission Denied");
      if (permission == LocationPermission.deniedForever) {
        showSnckBar(context, "Location permission permanantly denied");
      }
    }
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation,
            forceAndroidLocationManager: true)
        .then(
      (Position position) {
        setState(
          () {
            _currentPosition = position;
            _getAddressFromLatLong();
          },
        );
      },
    ).catchError(
      (e) {
        showSnckBar(
          context,
          e.toString(),
        );
      },
    );
  }

  _getAddressFromLatLong() async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placeMarks[0];
      setState(
        () {
          _currentAddress =
              "${place.locality},${place.postalCode},${place.street},";
        },
      );
    } catch (e) {
      showSnckBar(
        context,
        e.toString(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  showmodelforsos(
    BuildContext context,
  ) {
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
                  "Send Your Current Location to Emergency Contacts",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                getlocationbtnsos(),
                SizedBox(height: 10),
                sendalertbtnsos(),
              ],
            ),
          ),
        );
      },
    );
  }

  GestureDetector sendalertbtnsos() {
    return GestureDetector(
      //onTap: ,
      onTap: () async {},
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
      onTap: () async {},
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
