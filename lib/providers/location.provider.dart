import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';

class LocationProvider extends ChangeNotifier {
  double? lat;
  double? long;
  String? accuracy;
  String? lastSync;
  String? address1;
  String? address2;
  String? address3;
  String? state;
  String? country;
  String? locality;
  final box = GetStorage();

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position _position = await Geolocator.getCurrentPosition(
        timeLimit: const Duration(seconds: 10),
        desiredAccuracy: LocationAccuracy.medium);
    box.write('lat', _position.latitude);
    box.write('long', _position.longitude);
    box.write('acc', _position.accuracy.toString());
    box.write('sync', _position.timestamp.toString());
    await getAddress(_position.latitude, _position.longitude);
    readLocal();
    notifyListeners();
  }

  getAddress(double lang, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lang, long);
    country = placemarks.first.country;
    state = placemarks.first.administrativeArea;
    locality = placemarks.first.locality;
    box.write('state', state);
    notifyListeners();
  }

  void readLocal() {
    if (box.read('lat') != null) {
      lat = box.read('lat');
    }
    if (box.read('long') != null) {
      long = box.read('long');
    }
    if (box.read('acc') != null) {
      accuracy = box.read('acc').toString();
    }
    if (box.read('sync') != null) {
      lastSync = box.read('sync').toString();
    }
  }

  void remove() {
    lat = null;
    long = null;
    accuracy = null;
    lastSync = null;
    state = null;
    country = null;
    removeLocal();
    notifyListeners();
  }

  void removeLocal() {
    box.remove('long');
    box.remove('lang');
    box.remove('acc');
    box.remove('sync');
    box.remove('state');
  }
}
