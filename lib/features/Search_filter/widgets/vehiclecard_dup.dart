import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/vehicle_details.dart';

class vehicle_card_search extends StatelessWidget {
  final String vehicleName;
  final int price;
  final String mainImage;

  const vehicle_card_search(
    this.vehicleName,
    this.price,
    this.mainImage, {
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
            side: BorderSide(
              color: theme.dividerColor.withOpacity(0.4),
              width: 0.5,
            ),
          ),
          color: theme.scaffoldBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                child: AspectRatio(
                  aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/car.jpg'),
                    image: NetworkImage(mainImage),
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.cover,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vehicleName,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyMedium
                ?.color, // Use the text color from the theme
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
        Text(
          " Rs $price/Day",
          style: TextStyle(
            color: theme.textTheme.bodySmall
                ?.color, // Use the text color from the theme
          ),
        ),
      ],
    ),
  );
}
