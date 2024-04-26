import 'dart:async';
import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    "Suraksha Sathi",
    "Foreground service",
    importance: Importance.low,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
      notificationChannelId: "Suraksha Sathi",
      initialNotificationTitle: "foreground service",
      initialNotificationContent: "initializing",
      foregroundServiceNotificationId: 888,
    ),
  );
  service.startService();
}

@pragma("vm-entry-point")
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen(
      (event) {
        service.setAsBackgroundService();
      },
    );
  }
  service.on('stopService').listen(
    (event) {
      service.stopSelf();
    },
  );

  Timer.periodic(
    Duration(seconds: 2),
    (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          flutterLocalNotificationPlugin.show(
            888,
            'Suraksha Sathi',
            "shake feature enabled",
            NotificationDetails(
              android: AndroidNotificationDetails(
                  "Suraksha Sathi", "Foreground service",
                  icon: 'ic_bg_service_small', ongoing: true),
            ),
          );
        }
      }
    },
  );
}
