// import 'package:flutter/material.dart';
// import 'package:karconnect/features/bottomNavigationBar/bottomNavBar.dart';

// class dashboard extends StatelessWidget {
//   const dashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Theme"),
//         ),
//         bottomNavigationBar: BottomNavigationBarCustom(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:karconnect/features/bottomNavigationBar/bottomNavBar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBarCustom(),
      body: Padding(
        padding: EdgeInsets.only(top: padding.top),
      ),
    );
  }
}
