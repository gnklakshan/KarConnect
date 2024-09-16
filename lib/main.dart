//Main dart file
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karconnect/backend/firebase/firebase_options.dart';
import 'package:karconnect/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}
