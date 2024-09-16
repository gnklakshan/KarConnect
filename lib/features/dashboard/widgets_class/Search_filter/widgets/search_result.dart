import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karconnect/backend/data_fetch_and_represent/data_services/dataservice_from_collection.dart';
import 'package:karconnect/features/dashboard/widgets_class/Search_filter/widgets/vehiclecard_for_search.dart';

class Search_result_list extends StatefulWidget {
  final String collectionName;
  final String VehicleType;
  final String VehicleBrand;

  const Search_result_list({
    super.key,
    required this.collectionName,
    required this.VehicleType,
    required this.VehicleBrand,
  });

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
          .where('Availability', isEqualTo: 1)
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
                  return const Center(child: Text('No Vehicles available'));
                } else {
                  Map<String, String> vehicleDocIds = vehicleIdsSnapshot.data!;

                  // Filter the data_list to exclude items without a valid vehicleDocId
                  List<Map<String, dynamic>> filteredDataList =
                      data_list.where((data) {
                    String vehicleNumber = data['vehicle_no'];
                    return vehicleDocIds.containsKey(vehicleNumber);
                  }).toList();

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: filteredDataList.length,
                    itemBuilder: (context, index) {
                      String name = filteredDataList[index]["name"];
                      int price = filteredDataList[index]["price"];
                      String image = filteredDataList[index]["main_image"];
                      String vehicleNumber =
                          filteredDataList[index]["vehicle_no"];
                      String vehicleDocId = vehicleDocIds[vehicleNumber]!;

                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: vehicle_card_search(
                            name, price, image, vehicleDocId),
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
