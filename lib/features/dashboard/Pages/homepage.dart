import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karconnect/backend/data_fetch_and_represent/brandCard_dynamic_list.dart';
import 'package:karconnect/backend/data_fetch_and_represent/vehicle_card_dynamicList.dart';
import 'package:karconnect/features/dashboard/Pages/subpages/notification/notificatin.dart';
import 'package:karconnect/features/map_navigation/map_page.dart';

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
                  List_Title("Top Brand", "View all", context),
                  const SizedBox(
                    height: 15,
                  ),
                  Brand_list(collectionName: "car_brands"),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    child:
                        List_Title("Recent Best Cars", "View on Map", context),
                    onTap: () => Get.to(const MapPage()),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const vehicle_card_list(
                    collectionName: 'vehicle_db',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    child: List_Title(
                        "Available Near you", "View on Map", context),
                    onTap: () => Get.to(const MapPage()),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const vehicle_card_list(
                    collectionName: 'vehicle_db',
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  //Heading reuseable class

  Row List_Title(String Topic, String option, BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          Topic,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        )),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  option,
                  style: TextStyle(color: Color.fromARGB(255, 208, 128, 9)),
                )))
      ],
    );
  }
}

//App bar
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
