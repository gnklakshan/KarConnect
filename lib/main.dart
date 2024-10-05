import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:karconnect/backend/firebase/firebase_options.dart';
import 'package:karconnect/app.dart';
import 'package:karconnect/utils/constants/api_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up Stripe configuration
  await _setup();

  // Run the app
  runApp(const App());
}

Future<void> _setup() async {
  // Set the Stripe publishable key
  Stripe.publishableKey = APIConstants.stripepublishablekey;
}
