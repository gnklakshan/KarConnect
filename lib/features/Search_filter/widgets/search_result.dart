import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karconnect/backend/data_retrieve/dataservice_from_collection.dart';
import 'package:karconnect/features/dashboard/widgets_class/vehicleCard.dart';

class Search_result_list extends StatelessWidget {
  final String collectionName;
  final String VehicleType;
  final String VehicleBrand;
  const Search_result_list(
      {super.key,
      required this.collectionName,
      required this.VehicleType,
      required this.VehicleBrand});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: CollectionDataService().getFilteredCollectionData(
            collectionName, VehicleType, VehicleBrand),
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
            return ListView.builder(
              itemCount: data_list.length,
              itemBuilder: (context, index) {
                String name = data_list[index]["name"];
                int price = data_list[index]["price"];
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 4.0, left: 4), // Adjust the padding as needed
                  child: vehicle_card(name, price),
                );
                // return vehicle_card(name, price);
              },
            );
          }
        },
      ),
    );
  }
}
