import 'package:flutter/material.dart';
import 'package:karconnect/backend/data_fetch_and_represent/data_services/dataservice_from_collection.dart';
import 'package:karconnect/backend/data_fetch_and_represent/widgets/brandCard.dart';

class Brand_list extends StatelessWidget {
  final String collectionName;
  const Brand_list({super.key, required this.collectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
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
                String image_url = data_list[index]["url"];
                return BrandCard(context, name, image_url);
              },
            );
          }
        },
      ),
    );
  }
}
