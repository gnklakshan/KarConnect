import 'package:flutter/material.dart';
import 'package:get/get.dart';

class vehicle_card extends StatelessWidget {
  final String VehicleName;
  final int price;
  const vehicle_card(
    this.VehicleName,
    this.price, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: GestureDetector(
        onTap: () => Get.to(() => {}),
        child: Card.filled(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            // color: Color.fromARGB(255, 255, 255, 255),
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
                    )),
                VehicleCard_details(context, VehicleName, price),
              ],
            )),
      ),
    );
  }
}

Padding VehicleCard_details(
    BuildContext context, String VehicleName, int price) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            VehicleName,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0)),
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
        Align(alignment: Alignment.bottomLeft, child: Text(" Rs $price/Day"))
      ],
    ),
  );
}
