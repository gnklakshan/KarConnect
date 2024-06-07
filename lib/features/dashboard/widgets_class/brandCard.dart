import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karconnect/dummy_temp.dart';

Card BrandCard(String name, String path) {
  return Card(
    surfaceTintColor: Color.fromARGB(255, 255, 255, 255),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // if you need this
      side: BorderSide(
        color: Color.fromARGB(255, 53, 52, 52).withOpacity(0.2),
        width: 1,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Get.to(() => const dummy()),
        child: Column(
          children: [
            Image.network(
              path,
              height: 60,
              width: 60,
            ),
            // Image.asset(
            //   path,
            //   height: 60,
            //   width: 60,
            // ),
            Text(name),
          ],
        ),
      ),
    ),
  );
}
