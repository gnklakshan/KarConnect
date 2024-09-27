import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:karconnect/backend/data_fetch_and_represent/widgets/vehicleCard.dart';
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
  Set<Circle> _circles = {};
  GoogleMapController? _mapController;
  BitmapDescriptor? _carIcon;
  StreamSubscription<LocationData>? _locationSubscription;

  final double _geofenceRadius = 5000; // 5000 meters

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
        title: Text("Find Nearest Vehicles"),
        backgroundColor: Colors.white54,
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
                  circles: _circles,
                  mapType: MapType.normal,
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: FloatingActionButton(
                    backgroundColor: Color.fromARGB(247, 63, 138, 236),
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
            _updateGeofence();
          });
        }
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _updateGeofence() {
    if (_currentPosition != null) {
      setState(() {
        _circles = {
          Circle(
            circleId: CircleId("geofence"),
            center: _currentPosition!,
            radius: _geofenceRadius,
            fillColor: Colors.blue.withOpacity(0.1),
            strokeColor: Colors.blue,
            strokeWidth: 2,
          )
        };
      });
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
                  markerId: MarkerId(doc.id), //doc id on db
                  position: position,
                  icon: _carIcon ??
                      BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                  onTap: () => _showVehicleDetails(data, position, doc.id),
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

  void _showVehicleDetails(Map<String, dynamic> vehicleData,
      LatLng vehiclePosition, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: AlertDialog(
            backgroundColor: Colors.white10,
            title: IconButton(
              icon: Icon(
                Iconsax.close_circle,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            content: SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: vehicle_card(
                  vehicleData['name'],
                  vehicleData['price'],
                  vehicleData['main_image'],
                  documentId,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
