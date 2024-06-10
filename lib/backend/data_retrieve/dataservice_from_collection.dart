import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

//get data of specific doc in the given collection
  Future<Map<String, dynamic>?> getCollectionDocData(
      String collectionName, String docId) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore
        .instance
        .collection(collectionName)
        .doc(docId)
        .get();

    return docSnapshot.data();
  }

//filter results
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

//Get user profile details
  Future<Map<String, dynamic>?> get_user_data() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        return {
          'username': data['username'],
          'link': data['link'],
        };
      } else {
        return {
          'username': 'username',
          'link': 'null',
        }; // Handle the case where the document does not exist
      }
    } catch (e) {
      print("Error getting user data: $e");
      return null; // Handle the error accordingly
    }
  }
}
