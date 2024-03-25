import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as LatLng;

class mapsview extends StatefulWidget {
  const mapsview({super.key});

  @override
  State<mapsview> createState() => _mapsviewState();
}

class _mapsviewState extends State<mapsview> {
  // static const LatLng gplex = LatLng(37.4223, -122.0848);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng.LatLng(19.0760, 72.8777),
          initialZoom: 10,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/kartikkartik/clu74efqy001o01r54o2oa7ml/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2FydGlra2FydGlrIiwiYSI6ImNsamtuazc4aTBsNmszcm1ycnIyMm1qMTUifQ.jypNYO98K4hAXVrlZ-X1_w',
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
