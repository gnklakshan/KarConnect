import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karconnect/backend/data_retrieve/brandCard_dynamic_list.dart';
import 'package:karconnect/backend/data_retrieve/vehicle_card_dynamicList.dart';
import 'package:karconnect/dummy_temp.dart';
import 'package:karconnect/features/notification/notificatin.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LocationBar(context),
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

AppBar LocationBar(BuildContext context) {
  final theme = Theme.of(context);

  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 40,
              color: theme.iconTheme.color,
            ),
            const SizedBox(
              width: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Location",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.textTheme.bodyLarge?.color?.withOpacity(0.6),
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Colombo",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Get.to(() => const NotificationScreen());
            // NotificationScreen();
          },
          icon: Icon(
            Icons.notifications_none_outlined,
            size: 30,
            color: theme.iconTheme.color,
          ),
        ),
      ],
    ),
  );
}
