import 'package:flutter/material.dart';
import 'package:sos_app/widgets/home_widgets/emergencies.dart/ActiveEmergency.dart';
import 'package:sos_app/widgets/home_widgets/emergencies.dart/AmbulanceEmergency.dart';
import 'package:sos_app/widgets/home_widgets/emergencies.dart/FireBrigadeEmergency.dart';
import 'package:sos_app/widgets/home_widgets/emergencies.dart/forestdept.dart';
import 'package:sos_app/widgets/home_widgets/emergencies.dart/gasdept.dart';
import 'package:sos_app/widgets/home_widgets/emergencies.dart/policeemergemcy.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            ActiveEmergency(),
            AmbulanceEmergency(),
            FirebrigadeEmergency(),
            PoiliceEmergency(),
            gastdept(),
            forestdept(),
          ],
        ));
  }
}
