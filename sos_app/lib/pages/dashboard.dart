import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:latlong2/latlong.dart' as LatLng;

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng.LatLng(51.509364, -0.128928),
          initialZoom: 9.2,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/kartikkartik/clu57c0v400q501mj2sotef3b/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2FydGlra2FydGlrIiwiYSI6ImNsamtuazc4aTBsNmszcm1ycnIyMm1qMTUifQ.jypNYO98K4hAXVrlZ-X1_w',
            userAgentPackageName: 'com.example.app',
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoia2FydGlra2FydGlrIiwiYSI6ImNsamtuazc4aTBsNmszcm1ycnIyMm1qMTUifQ.jypNYO98K4hAXVrlZ-X1_w',
              'id': 'mapbox.mapbox-streets-v8',
            },
          ),
        ],
      ),
    );
  }
}
