import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/vehicle_details.dart';

class fetch_vehicle_Data extends StatefulWidget {
  final String collectionName;
  final String docId;

  const fetch_vehicle_Data(
      {super.key, required this.collectionName, required this.docId});

  @override
  State<fetch_vehicle_Data> createState() => _VehicleCardListState();
}

class _VehicleCardListState extends State<fetch_vehicle_Data> {
  Future<Map<String, dynamic>?> getCollectionDocData(
      String collectionName, String docId) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore
        .instance
        .collection(collectionName)
        .doc(docId)
        .get();

    return docSnapshot.data();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: getCollectionDocData(widget.collectionName, widget.docId),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          } else {
            Map<String, dynamic> VehicleData = snapshot.data!;
            String name = VehicleData["name"];
            int price = VehicleData["price"];
            String owner = VehicleData["owner"];
            String image = VehicleData["main_image"];
            String description = VehicleData["description"];
            print(name);

            return VehicleDetails(
                name, price, owner, image, description, widget.docId);
          }
        },
      ),
    );
  }
}
