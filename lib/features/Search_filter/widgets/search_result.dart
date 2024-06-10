import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karconnect/backend/data_retrieve/dataservice_from_collection.dart';
import 'package:karconnect/features/Search_filter/widgets/vehiclecard_dup.dart';

class Search_result_list extends StatefulWidget {
  final String collectionName;
  final String VehicleType;
  final String VehicleBrand;
  const Search_result_list(
      {super.key,
      required this.collectionName,
      required this.VehicleType,
      required this.VehicleBrand});

  @override
  State<Search_result_list> createState() => _Search_result_listState();
}

class _Search_result_listState extends State<Search_result_list> {
  Future<Map<String, String>> _getVehicleDocIds(
      List<String> vehicleNumbers) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: CollectionDataService().getFilteredCollectionData(
            widget.collectionName, widget.VehicleType, widget.VehicleBrand),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No search result available'));
          } else {
            List<Map<String, dynamic>> data_list = snapshot.data!;
            List<String> vehicleNumbers =
                data_list.map((data) => data['vehicle_no'] as String).toList();
            return FutureBuilder<Map<String, String>>(
              future: _getVehicleDocIds(vehicleNumbers),
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
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: data_list.length,
                    itemBuilder: (context, index) {
                      String name = data_list[index]["name"];
                      int price = data_list[index]["price"];
                      String image = data_list[index]["main_image"];
                      String vehicleNumber = data_list[index]["vehicle_no"];
                      String? vehicleDocId = vehicleDocIds[vehicleNumber];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: vehicleDocId != null
                            ? vehicle_card_search(
                                name, price, image, vehicleDocId)
                            : const SizedBox(),
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
