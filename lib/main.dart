import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationPermissionScreen(),
    );
  }
}

class LocationPermissionScreen extends StatefulWidget {
  @override
  _LocationPermissionScreenState createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  // Request location permission in two steps
  Future<void> requestLocationPermission() async {
    // Step 1: Request 'when in use' permission first
    PermissionStatus status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      // Step 2: After granting 'when in use', request 'always' permission
      PermissionStatus alwaysStatus = await Permission.locationAlways.request();
      if (alwaysStatus.isGranted) {
        // Permission granted, proceed to use location
        print("Location permission granted: Always");
      } else {
        // Permission denied for always
        print("Location permission denied: Always");
      }
    } else {
      // Permission denied for when in use
      print("Location permission denied: When In Use");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location Permission Example')),
      body: Center(child: Text('Requesting Location Permission...')),
    );
  }
}
