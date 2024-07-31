import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addRentedVehicle(String vehicleID, String startDate,
    String endDate, String startTime, String endTime) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // add a new user with a custom doc ID
  return users
      .doc(uid)
      .collection("rent_vehicles")
      .add({
        'VehicleID': vehicleID,
        'StartDate': startDate,
        'EndDate': endDate,
        'StartTime': startTime,
        'EndTime': endTime,
        'confirm': 0,
        'pending': 1,
        'cancel': 0
      })
      .then((value) => print("add rented vehicle"))
      .catchError((error) => print("Failed to add vehicle: $error"));
}

Future<void> RentedVehicleList(String vehicleID, String startDate,
    String endDate, String startTime, String endTime) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference current_rent =
      FirebaseFirestore.instance.collection('current_rent');

  // add a new user with a custom doc ID
  return current_rent
      .doc(vehicleID)
      .set({
        'VehicleID': vehicleID,
        'RentUser': uid,
        'confirm': 0,
        'pending': 1,
        'cancel': 0
      })
      .then((value) => print("add rented vehicle"))
      .catchError((error) => print("Failed to add vehicle: $error"));
}

Future<void> updateVehicleAvailability(String vehicleID) async {
  CollectionReference vehicles =
      FirebaseFirestore.instance.collection('vehicle_db');

  try {
    await vehicles.doc(vehicleID).update({
      'Availability': 0,
    });
    print("Availability updated successfully.");
  } catch (e) {
    print("Failed to update vehicle availability: $e");
  }
}
