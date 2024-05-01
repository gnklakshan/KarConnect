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

void signOut() async {
  await _auth.signOut();
}
