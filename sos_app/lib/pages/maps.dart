import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart' as LatLng;

class mapsview extends StatefulWidget {
  const mapsview({super.key});

  @override
  State<mapsview> createState() => _mapsviewState();
}

class _mapsviewState extends State<mapsview> {
  // static const LatLng gplex = LatLng(37.4223, -122.0848);
  // LocationData? _currentLocationss;
  // Location _location = Location();
  // Position? _curentPosition;

  // Future<bool> handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   _requestLocationPermission();
  // }

  // Future<void> _requestLocationPermission() async {
  //   bool serviceEnabled = await _location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await _location.requestService();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }

  //   PermissionStatus permissionStatus = await _location.hasPermission();
  //   if (permissionStatus == PermissionStatus.denied) {
  //     permissionStatus = await _location.requestPermission();
  //     if (permissionStatus != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _location.onLocationChanged.listen((LocationData locationData) {
  //     setState(() {
  //       _currentLocationss = locationData;
  //     });
  //   });
  // }

  // Future<void> getCurrentLocation() async {
  //   bool isLocationPermissionGranted = await requestLocationPermission();
  //   if (isLocationPermissionGranted) {
  //     Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best,
  //     );
  //     // _getAddressFromLatLon();
  //     setState(() {
  //       _curentPosition = position;
  //     });
  //   } else {
  //     // Handle case when location permission is not granted
  //     print('Location permission denied.');
  //   }
  // }

  // Future<bool> requestLocationPermission() async {
  //   PermissionStatus permission = await Permission.location.request();
  //   return permission == PermissionStatus.granted;
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   //getCurrentLocation();
  //   handleLocationPermission();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          // initialCenter: LatLng.LatLng(
          //   _currentLocationss?.latitude ?? 0.0,
          //   _currentLocationss?.longitude ?? 0.0,
          // ),
          initialCenter: LatLng.LatLng(19.180167565322655, 72.98022091187102),
          initialZoom: 18,
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
          CurrentLocationLayer(
            followOnLocationUpdate: FollowOnLocationUpdate.always,
            turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
            style: LocationMarkerStyle(
              marker: const DefaultLocationMarker(
                child: Icon(
                  Icons.navigation,
                  color: Colors.white,
                ),
              ),
              markerSize: const Size(40, 40),
              markerDirection: MarkerDirection.heading,
            ),
          )
          // MarkerLayer(
          //   markers: [
          //     Marker(
          //       width: 80.0,
          //       height: 80.0,
          //       point: LatLng.LatLng(
          //         // _currentLocationss?.latitude ?? 0.0,
          //         // _currentLocationss?.longitude ?? 0.0,
          //       ), // Replace with your latitude and longitude

          //       child: Icon(Icons.location_on, color: Colors.red),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
