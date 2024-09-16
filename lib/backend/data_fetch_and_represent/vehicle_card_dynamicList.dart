import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karconnect/backend/data_fetch_and_represent/data_services/dataservice_from_collection.dart';
import 'package:karconnect/backend/data_fetch_and_represent/widgets/vehicleCard.dart';

class vehicle_card_list extends StatefulWidget {
  final String collectionName;

  const vehicle_card_list({super.key, required this.collectionName});

  @override
  State<vehicle_card_list> createState() => _vehicle_card_listState();
}

class _vehicle_card_listState extends State<vehicle_card_list> {
  Stream<Map<String, String>> _getVehicleDocIdsStream(
      Stream<List<Map<String, dynamic>>> dataStream) {
    return dataStream.asyncMap((dataList) async {
      List<String> vehicleNumbers =
          dataList.map((data) => data['vehicle_no'] as String).toList();
      Map<String, String> vehicleDocIds = {};
      for (String vehicleNumber in vehicleNumbers) {
        var data = await FirebaseFirestore.instance
            .collection('vehicle_db')
            .where('vehicle_no', isEqualTo: vehicleNumber)
            .get();
        if (data.docs.isNotEmpty) {
          vehicleDocIds[vehicleNumber] = data.docs[0].id;
        }
      }
      return vehicleDocIds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245,
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: CollectionDataService()
            .getCollectionDataStream(widget.collectionName),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<Map<String, dynamic>> dataList = snapshot.data!;

            return StreamBuilder<Map<String, String>>(
              stream: _getVehicleDocIdsStream(Stream.value(dataList)),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, String>> vehicleIdsSnapshot) {
                if (vehicleIdsSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (vehicleIdsSnapshot.hasError) {
                  return Center(
                      child: Text('Error: ${vehicleIdsSnapshot.error}'));
                } else if (vehicleIdsSnapshot.data == null ||
                    vehicleIdsSnapshot.data!.isEmpty) {
                  return const Center(child: Text('No document IDs available'));
                } else {
                  Map<String, String> vehicleDocIds = vehicleIdsSnapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      String name = dataList[index]["name"];
                      int price = dataList[index]["price"];
                      String image = dataList[index]["main_image"];
                      String vehicleNumber = dataList[index]["vehicle_no"];
                      String? vehicleDocId = vehicleDocIds[vehicleNumber];

                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: vehicle_card(name, price, image, vehicleDocId!),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
