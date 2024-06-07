import 'package:flutter/material.dart';
import 'package:karconnect/features/bottomNavigationBar/bottomNavBar.dart';

class dummy extends StatelessWidget {
  const dummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dummy"),
      ),
      body: Center(child: Text("Need To Design")),
    );
  }
}
