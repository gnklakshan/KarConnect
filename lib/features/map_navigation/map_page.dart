// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   final Location _locationController = Location();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   LatLng? _currentPosition;
//   Set<Marker> _markers = {};
//   GoogleMapController? _mapController;

//   @override
//   void initState() {
//     super.initState();
//     getLocationUpdates();
//     fetchVehicles();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Locate Nearest Vehicles"),
//       ),
//       body: _currentPosition == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: _currentPosition!,
//                 zoom: 14,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 _mapController = controller;
//               },
//               myLocationEnabled: true,
//               markers: _markers,
//             ),
//     );
//   }

//   Future<void> getLocationUpdates() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     // Check if location service is enabled
//     _serviceEnabled = await _locationController.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _locationController.requestService();
//       if (!_serviceEnabled) return;
//     }

//     // Check for location permission
//     _permissionGranted = await _locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) return;
//     }

//     // Listen to location changes
//     _locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         setState(() {
//           _currentPosition =
//               LatLng(currentLocation.latitude!, currentLocation.longitude!);
//           if (_mapController != null) {
//             _mapController!
//                 .animateCamera(CameraUpdate.newLatLng(_currentPosition!));
//           }
//         });
//       }
//     });
//   }

//   Future<void> fetchVehicles() async {
//     try {
//       QuerySnapshot vehiclesSnapshot =
//           await _firestore.collection('vehicle_db').get();

//       setState(() {
//         // Use where to filter out any null markers
//         _markers = vehiclesSnapshot.docs
//             .map((doc) {
//               Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

//               // Extract the GeoPoint from the location field
//               GeoPoint? geoPoint = data['location'] as GeoPoint?;

//               // Ensure the GeoPoint is present
//               if (geoPoint != null) {
//                 LatLng position = LatLng(geoPoint.latitude, geoPoint.longitude);

//                 return Marker(
//                   markerId: MarkerId(doc.id),
//                   position: position,
//                   icon: BitmapDescriptor.defaultMarkerWithHue(
//                       BitmapDescriptor.hueGreen),
//                   onTap: () => _showVehicleDetails(data),
//                 );
//               } else {
//                 // If GeoPoint is missing, return null
//                 return null;
//               }
//             })
//             .where((marker) => marker != null)
//             .cast<Marker>()
//             .toSet(); // Filter out null values
//       });
//     } catch (e) {
//       print("Error fetching vehicles: $e");
//     }
//   }

//   void _showVehicleDetails(Map<String, dynamic> vehicleData) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(vehicleData['name'] ?? 'Vehicle Details'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text("Model: ${vehicleData['model'] ?? 'N/A'}"),
//               Text("Battery: ${vehicleData['battery'] ?? 'N/A'}"),
//               Text(
//                   "Unlock Fee: \$${vehicleData['unlockFee']?.toStringAsFixed(2) ?? 'N/A'}"),
//               Text(
//                   "Rate: \$${vehicleData['rate']?.toStringAsFixed(2) ?? 'N/A'}/min"),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: Text("Close"),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             ElevatedButton(
//               child: Text("Book Ride"),
//               onPressed: () {
//                 // Implement booking logic here
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Location _locationController = Location();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LatLng? _currentPosition;
  Set<Marker> _markers = {};
  GoogleMapController? _mapController;
  BitmapDescriptor? _carIcon;
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _initializeMapData();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _initializeMapData() async {
    await _createCarMarkerIcon();
    await getLocationUpdates();
    await fetchVehicles();
  }

  Future<void> _createCarMarkerIcon() async {
    if (!mounted) return;
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/car_icon.png', 50);
    _carIcon = BitmapDescriptor.fromBytes(markerIcon);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await DefaultAssetBundle.of(context).load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locate Nearest Vehicles"),
        backgroundColor: Colors.blue,
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: _markers,
                  mapType: MapType.normal,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: FloatingActionButton(
                    child: Icon(Icons.refresh),
                    onPressed: fetchVehicles,
                    tooltip: 'Refresh Vehicles',
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    try {
      _serviceEnabled = await _locationController.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _locationController.requestService();
        if (!_serviceEnabled) return;
      }

      _permissionGranted = await _locationController.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _locationController.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) return;
      }

      _locationSubscription = _locationController.onLocationChanged
          .listen((LocationData currentLocation) {
        if (mounted &&
            currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          setState(() {
            _currentPosition =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            if (_mapController != null) {
              _mapController!
                  .animateCamera(CameraUpdate.newLatLng(_currentPosition!));
            }
          });
        }
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> fetchVehicles() async {
    if (!mounted) return;
    try {
      QuerySnapshot vehiclesSnapshot =
          await _firestore.collection('vehicle_db').get();

      setState(() {
        _markers = vehiclesSnapshot.docs
            .map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              GeoPoint? geoPoint = data['location'] as GeoPoint?;

              if (geoPoint != null) {
                LatLng position = LatLng(geoPoint.latitude, geoPoint.longitude);
                return Marker(
                  markerId: MarkerId(doc.id),
                  position: position,
                  icon: _carIcon ??
                      BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                  onTap: () => _showVehicleDetails(data),
                );
              } else {
                return null;
              }
            })
            .where((marker) => marker != null)
            .cast<Marker>()
            .toSet();
      });
    } catch (e) {
      print("Error fetching vehicles: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load vehicles. Please try again.")),
        );
      }
    }
  }

  void _showVehicleDetails(Map<String, dynamic> vehicleData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(vehicleData['name'] ?? 'Vehicle Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Model: ${vehicleData['model'] ?? 'N/A'}"),
                Text("Battery: ${vehicleData['battery'] ?? 'N/A'}"),
                Text(
                    "Unlock Fee: \$${vehicleData['unlockFee']?.toStringAsFixed(2) ?? 'N/A'}"),
                Text(
                    "Rate: \$${vehicleData['rate']?.toStringAsFixed(2) ?? 'N/A'}/min"),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text("Book Ride"),
              onPressed: () {
                // Implement booking logic here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Booking feature coming soon!")),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
