import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sos_app/widgets/near%20comodities/BusStops.dart';
import 'package:sos_app/widgets/near%20comodities/Hospitals.dart';
import 'package:sos_app/widgets/near%20comodities/Pharmacies.dart';
import 'package:sos_app/widgets/near%20comodities/PoliceStationCard.dart';
import 'package:sos_app/widgets/near%20comodities/toilets.dart';
import 'package:url_launcher/url_launcher.dart';

class nearcomodity extends StatelessWidget {
  const nearcomodity({super.key});

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';

    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            PoliceStationCard(onMapFunction: openMap),
            Hospitals(onMapFunction: openMap),
            Pharmacies(onMapFunction: openMap),
            busStops(onMapFunction: openMap),
            toilets(onMapFunction: openMap),
          ],
        ),
      ),
    );
  }
}
