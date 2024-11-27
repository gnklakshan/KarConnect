import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class dummy extends StatelessWidget {
  const dummy({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("dummy $uid"),
      ),
      body: Center(child: Text("Need To Design")),
    );
  }
}
