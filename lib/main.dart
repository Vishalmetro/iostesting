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
    _checkAndRequestLocationPermission();
  }

  // Function to request location permission
  Future<void> _checkAndRequestLocationPermission() async {
    // Request "When In Use" permission first
    PermissionStatus status = await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      // If "When In Use" is granted, request "Always" permission
      await _requestAlwaysPermission();
    } else {
      // If "When In Use" is denied, show a dialog asking for permission
      _showPermissionDialog();
    }
  }

  // Function to request "Always" location permission
  Future<void> _requestAlwaysPermission() async {
    PermissionStatus alwaysStatus = await Permission.locationAlways.request();

    if (alwaysStatus.isGranted) {
      // "Always" permission granted
      print("Location permission granted: Always");
    } else {
      // "Always" permission denied, show a dialog again
      _showPermissionDialog();
    }
  }

  // Function to show dialog to explain why permission is needed
  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Required'),
          content: Text('We need your location to provide location-based services. Please allow "Always" location permission.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _checkAndRequestLocationPermission(); // Request permission again
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location Permission Example')),
      body: Center(child: Text('Requesting Location Permission...')),
    );
  }
}
