import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionDataService {
  Future<List<Map<String, dynamic>>> get_collection_data(
      String collection_name) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection(collection_name).get();

    List<Map<String, dynamic>> data = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    return data;
  }

  Future<List<Map<String, dynamic>>> getFilteredCollectionData(
    String collectionName,
    String vehicleType,
    String vehicleBrand,
  ) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(collectionName);

    if (vehicleType != 'null' && vehicleBrand != 'null') {
      query = query
          .where("type", isEqualTo: vehicleType.toLowerCase())
          .where("brand", isEqualTo: vehicleBrand.toLowerCase());
    }

    if (vehicleType != 'null' && vehicleBrand == 'null') {
      query = query.where("type", isEqualTo: vehicleType.toLowerCase());
    }

    if (vehicleBrand != 'null' && vehicleType == 'null') {
      query = query.where("brand", isEqualTo: vehicleBrand.toLowerCase());
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();

    List<Map<String, dynamic>> data = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    print("Data = $data");
    print("--------------. $vehicleBrand  and $vehicleType");
    querySnapshot.docs.forEach((doc) {
      print("Document ID: ${doc.id}");
      print("Document Data: ${doc.data()}");
    });

    return data;
  }
}
