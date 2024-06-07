import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karconnect/backend/data_retrieve/temp_dynamic_list.dart';
import 'package:karconnect/backend/data_retrieve/vehicle_card_dynamicList.dart';
// import 'package:karconnect/backend/temp_dynamic_list.dart';
// import 'package:karconnect/backend/vehicle_card_dynamicList.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LocationBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  List_Title("Top Brand", context),
                  const SizedBox(
                    height: 15,
                  ),
                  Brand_list(collectionName: "car_brands"),
                  const SizedBox(
                    height: 15,
                  ),
                  List_Title("Recent Best Cars", context),
                  const SizedBox(
                    height: 15,
                  ),
                  vehicle_card_list(
                    collectionName: 'vehicle_db',
                  ),

                  // GestureDetector(
                  //     onTap: () => Get.toNamed('/details'),
                  //     child: const vehicle_card()),
                  SizedBox(
                    height: 15,
                  ),
                  List_Title("Available Near you", context),
                  const SizedBox(
                    height: 15,
                  ),
                  vehicle_card_list(
                    collectionName: 'vehicle_db',
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Row List_Title(String Topic, BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          Topic,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        )),
        const Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "View all",
                  style: TextStyle(color: Color.fromARGB(255, 208, 128, 9)),
                )))
      ],
    );
  }
}

AppBar LocationBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 36,
            ),
            SizedBox(
              width: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Location",
                  style: TextStyle(
                      color: Color.fromARGB(122, 0, 0, 0),
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
                Text(
                  "Colombo",
                  style: TextStyle(
                      color: Color.fromARGB(146, 0, 0, 0), fontSize: 20),
                ),
              ],
            ),
          ],
        ),
        IconButton(
            onPressed: () {
              Get.toNamed("/dummy");
            },
            icon: Icon(Icons.notifications_none_outlined, size: 30))
      ],
    ),
  );
}

//----------------------------------------------------------------
//wth silver app bar-----------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:karconnect/backend/temp_dynamic_list.dart';
// import 'package:karconnect/backend/vehicle_card_dynamicList.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             const SliverAppBar(
//               expandedHeight: 20.0,
//               leading: Icon(Icons.location_pin),
//               // floating: true,
//               // pinned: true,
//             ),
//             SliverPadding(
//               padding: EdgeInsets.all(8.0),
//               sliver: SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     List_Title("Top Brand", context),
//                     const SizedBox(height: 6),
//                     const Brand_list(collectionName: "car_brands"),
//                     const SizedBox(height: 10),
//                     List_Title("Recent Best Cars", context),
//                     const vehicle_card_list(collectionName: 'vehicle_db'),
//                     const SizedBox(height: 10),
//                     List_Title("Available Near you", context),
//                     const SizedBox(height: 6),
//                     const vehicle_card_list(collectionName: 'vehicle_db'),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Row List_Title(String Topic, BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Text(
//             Topic,
//             style: Theme.of(context).appBarTheme.titleTextStyle,
//           ),
//         ),
//         Expanded(
//           child: Align(
//             alignment: Alignment.centerRight,
//             child: Text(
//               "View all",
//               style: TextStyle(color: const Color.fromARGB(255, 208, 128, 9)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


