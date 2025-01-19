import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:mis_lab_04/services/notification_service.dart';
import 'package:mis_lab_04/services/event_service.dart';

class LocationService {
  static Future<void> initializeBackgroundGeolocation() async {
    await bg.BackgroundGeolocation.ready(bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 50, // meters
      stopOnTerminate: false, // Keep running in background
      startOnBoot: true, // Start on boot
      enableHeadless: true, // For background service
      notificationTitle: "Локацијата се следи",
      notificationText: "Следењето на локацијата е активно.",
    ));

    // Request permission
    await bg.BackgroundGeolocation.requestPermission();

    _addGeofence();

    // Start the background geolocation service
    bg.BackgroundGeolocation.start();
  }

  static void _addGeofence() {
    final events = EventService.getEvents();

    for (var event in events) {
      bg.BackgroundGeolocation.addGeofence(bg.Geofence(
        identifier: event.id.toString(),
        radius: 100, // meters
        latitude: event.latitude,
        longitude: event.longitude,
        notifyOnEntry: true,
        extras: {
          "message":
              "Се приближувате на ${event.name} во просторијата ${event.location}"
        },
      ));
    }

    bg.BackgroundGeolocation.onGeofence((geofenceEvent) {
      if (geofenceEvent.action == "ENTER") {
        NotificationService.showNotification(
            "Календар", geofenceEvent.extras?["message"]);
      }
    });
  }
}
