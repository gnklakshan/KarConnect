import 'package:flutter/material.dart';
import 'package:karconnect/features/bottomNavigationBar/bottomNavBar.dart';

class dashboard extends StatelessWidget {
  const dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BottomNavigationBarCustom()),
    );
  }
}
