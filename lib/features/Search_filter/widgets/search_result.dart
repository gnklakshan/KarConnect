import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karconnect/backend/data_retrieve/dataservice_from_collection.dart';
import 'package:karconnect/features/Search_filter/widgets/vehiclecard_dup.dart';

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
    return SizedBox(
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
                return Padding(
                  padding:
                      const EdgeInsets.all(4.0), // Adjust the padding as needed
                  child: vehicle_card_search(name, price, image),
                );
              },
            );
            // return ListView.builder(
            //   itemCount: data_list.length,
            //   itemBuilder: (context, index) {
            //     String name = data_list[index]["name"];
            //     int price = data_list[index]["price"];
            //     String image = data_list[index]["main_image"];
            //     return Padding(
            //       padding: const EdgeInsets.only(
            //           right: 4.0, left: 4), // Adjust the padding as needed
            //       child: vehicle_card(name, price, image),
            //     );
            //     // return vehicle_card(name, price);
            //   },
            // );
          }
        },
      ),
    );
  }
}
