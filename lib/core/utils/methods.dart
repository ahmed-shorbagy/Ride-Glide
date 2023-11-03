import 'dart:math';

import 'dart:ui' as ui;
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_glide/core/utils/App_images.dart';

String? lightMapStyle;
String? darkMapStyle;

void loadMapStyles() async {
  lightMapStyle = await rootBundle.loadString(Assets.MapsLightMode);
  darkMapStyle = await rootBundle.loadString(Assets.MapsDarkMode);
}

void snackBar(BuildContext context, String massage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Theme.of(context).primaryColor,
    behavior: SnackBarBehavior.floating,
    width: 200,
    shape: const StadiumBorder(),
    content: Text(massage),
    padding: const EdgeInsets.all(12),
    duration: const Duration(seconds: 2),
  ));
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.openLocationSettings();
    }
  }

  if (permission == LocationPermission.deniedForever) {}

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: 100);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

double calculateDistance(LatLng start, LatLng end) {
  const double radiusOfEarth = 6371.0; // Earth's radius in kilometers

  // Convert degrees to radians
  double lat1 = start.latitude * (pi / 180);
  double lon1 = start.longitude * (pi / 180);
  double lat2 = end.latitude * (pi / 180);
  double lon2 = end.longitude * (pi / 180);

  // Haversine formula
  double dLat = lat2 - lat1;
  double dLon = lon2 - lon1;

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Calculate distance
  double distance = radiusOfEarth * c;
  return distance;
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
