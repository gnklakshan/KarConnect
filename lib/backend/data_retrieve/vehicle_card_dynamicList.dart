import 'package:flutter/material.dart';
import 'package:karconnect/backend/data_retrieve/dataservice_from_collection.dart';
import 'package:karconnect/features/dashboard/widgets_class/vehicleCard.dart';

class vehicle_card_list extends StatelessWidget {
  final String collectionName;
  const vehicle_card_list({super.key, required this.collectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: CollectionDataService().get_collection_data(collectionName),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<Map<String, dynamic>> data_list = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data_list.length,
              itemBuilder: (context, index) {
                String name = data_list[index]["name"];
                int price = data_list[index]["price"];
                String image = data_list[index]["main_image"];
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 4.0), // Adjust the padding as needed
                  child: vehicle_card(name, price, image),
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
