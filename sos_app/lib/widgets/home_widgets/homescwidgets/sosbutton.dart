import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class SOSbtn extends StatefulWidget {
  const SOSbtn({super.key});

  @override
  State<SOSbtn> createState() => _SOSbtnState();
}

class _SOSbtnState extends State<SOSbtn> {
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

  showmodelforsos(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height / 1.4,
            color: Colors.amber);
      },
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
