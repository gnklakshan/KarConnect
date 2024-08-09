import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:karconnect/features/dashboard/widgets_class/book_details_card.dart';

class VehicleBookedList extends StatelessWidget {
  String type;
  final Icon icon_name;

  /// confirm , cancel or pending
  VehicleBookedList({super.key, required this.type, required this.icon_name});

  Future<Map<String, dynamic>?> fetchVehicleDetails(String vehicleId) async {
    try {
      DocumentSnapshot vehicleSnapshot = await FirebaseFirestore.instance
          .collection('vehicle_db')
          .doc(vehicleId)
          .get();

      if (vehicleSnapshot.exists) {
        return vehicleSnapshot.data() as Map<String, dynamic>;
      } else {
        print('Vehicle not found in vehicle_db');
        return null;
      }
    } catch (e) {
      print('Error fetching vehicle details: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('rent_vehicles')
          .where(type, isEqualTo: 1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          icon_name;
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return icon_name;
        }

        final Rented_Vehicle = snapshot.data!.docs;

        return ListView.builder(
          itemCount: Rented_Vehicle.length,
          itemBuilder: (context, index) {
            final vehicle =
                Rented_Vehicle[index].data() as Map<String, dynamic>;

            String vehicleId = vehicle['VehicleID'] ?? '';
            print("id       :     " + vehicleId);

            return FutureBuilder<Map<String, dynamic>?>(
              future: fetchVehicleDetails(vehicleId),
              builder: (context, vehicleSnapshot) {
                final vehicleDetails = vehicleSnapshot.data;
                print(vehicleDetails);
                if (vehicleDetails == null) {
                  return Center(child: Text('Vehicle details not found'));
                }

                // Extract date and time
                String startDateStr = vehicle['StartDate'] ?? 'Unknown Date';
                String startTimeStr = vehicle['StartTime'] ?? 'Unknown Time';
                String endDateStr = vehicle['EndDate'] ?? 'Unknown Date';
                String endTimeStr = vehicle['EndTime'] ?? 'Unknown Time';

                // Parse date and time
                DateTime? startDateTime;
                DateTime? endDateTime;

                try {
                  startDateTime = DateFormat('MM-dd-yyyy hh:mm a')
                      .parse('$startDateStr $startTimeStr');
                  endDateTime = DateFormat('MM-dd-yyyy hh:mm a')
                      .parse('$endDateStr $endTimeStr');
                } catch (e) {
                  print('Error parsing date/time: $e');
                }

                return VehicleBookedCard(
                  imageUrl: vehicleDetails['main_image'],
                  vehicleName: vehicleDetails['name'] ?? 'Unknown Vehicle',
                  pricePerDay: vehicleDetails['price'] ?? 0,
                  startDateTime: startDateTime != null
                      ? DateFormat('MMM d, yyyy').format(startDateTime) +
                          '  |  ' +
                          DateFormat('h:mm a').format(startDateTime)
                      : 'Unknown Start Date and Time',
                  endDateTime: endDateTime != null
                      ? DateFormat('MMM d, yyyy').format(endDateTime) +
                          '  |  ' +
                          DateFormat('h:mm a').format(endDateTime)
                      : 'Unknown End Date and Time',
                );
              },
            );
          },
        );
      },
    );
  }
}
