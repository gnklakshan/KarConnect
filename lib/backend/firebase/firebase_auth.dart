import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<UserCredential?> registerWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<UserCredential?> signInWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<void> addNewUser(String firstName, String LastName, String username,
    String email, String phoneNum) {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // add a new user with a custom doc ID
  return users
      .doc(uid)
      .set({
        'first_name': firstName,
        'last_name': LastName,
        'username': username,
        'email': email,
        'phone_number': phoneNum,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

void signOut() async {
  await _auth.signOut();
}
