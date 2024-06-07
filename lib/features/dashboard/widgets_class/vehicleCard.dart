// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:karconnect/dummy_temp.dart';
// import 'package:karconnect/features/rent_features/screens/vehicle_details/vehicle_details.dart';

// class vehicle_card extends StatelessWidget {
//   final String VehicleName;
//   final int price;
//   const vehicle_card(
//     this.VehicleName,
//     this.price, {
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150,
//       child: GestureDetector(
//         onTap: () => Get.to(() => const VehicleDetails()),
//         child: Card.filled(
//             elevation: 2,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             // color: Color.fromARGB(255, 255, 255, 255),
//             child: Column(
//               children: [
//                 Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20.0),
//                       child: Image.asset(
//                         'assets/images/car.jpg',
//                         fit: BoxFit.fill,
//                       ),
//                     )),
//                 vehicle_card_details(context, VehicleName, price),
//               ],
//             )),
//       ),
//     );
//   }
// }

// Padding vehicle_card_details(
//     BuildContext context, String VehicleName, int price) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       children: [
//         Align(
//           alignment: Alignment.bottomLeft,
//           child: Text(
//             VehicleName,
//             style: TextStyle(
//                 fontSize: 15.0,
//                 fontWeight: FontWeight.w600,
//                 color: Color.fromARGB(255, 0, 0, 0)),
//           ),
//         ),
//         const Row(
//           children: [
//             Icon(
//               Icons.star_border,
//               color: Colors.deepOrange,
//               size: 18,
//             ),
//             Icon(
//               Icons.star_border,
//               color: Colors.deepOrange,
//               size: 18,
//             ),
//             Icon(
//               Icons.star_border,
//               color: Colors.deepOrange,
//               size: 18,
//             ),
//             Icon(
//               Icons.star_border,
//               size: 18,
//             ),
//             Icon(
//               Icons.star_border,
//               size: 18,
//             )
//           ],
//         ),
//         Align(alignment: Alignment.bottomLeft, child: Text(" Rs $price/Day"))
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/vehicle_details.dart';

class vehicle_card extends StatelessWidget {
  final String vehicleName;
  final int price;

  const vehicle_card(
    this.vehicleName,
    this.price, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return Container(
      width: 150,
      child: GestureDetector(
        onTap: () => Get.to(() => const VehicleDetails()),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: theme
              .scaffoldBackgroundColor, // Use the primary color from the theme
          child: Column(
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    'assets/images/car.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              vehicle_cardDetails(context, vehicleName, price),
            ],
          ),
        ),
      ),
    );
  }
}

Padding vehicle_cardDetails(
    BuildContext context, String vehicleName, int price) {
  final theme = Theme.of(context);

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            vehicleName,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodyMedium
                  ?.color, // Use the text color from the theme
            ),
          ),
        ),
        const Row(
          children: [
            Icon(
              Icons.star_border,
              color: Colors.deepOrange,
              size: 18,
            ),
            Icon(
              Icons.star_border,
              color: Colors.deepOrange,
              size: 18,
            ),
            Icon(
              Icons.star_border,
              color: Colors.deepOrange,
              size: 18,
            ),
            Icon(
              Icons.star_border,
              size: 18,
            ),
            Icon(
              Icons.star_border,
              size: 18,
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            " Rs $price/Day",
            style: TextStyle(
              color: theme.textTheme.bodySmall
                  ?.color, // Use the text color from the theme
            ),
          ),
        ),
      ],
    ),
  );
}
