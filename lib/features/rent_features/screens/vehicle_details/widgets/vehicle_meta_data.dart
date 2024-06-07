import 'package:karconnect/common/widgets/custom_widgets/containers/rounded_container.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/widgets/product_titile_text.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/widgets/vehicle_price_text.dart';
import 'package:karconnect/utils/constants/colors.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TVehicleMetaData extends StatelessWidget {
  const TVehicleMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title

        const TVehicleTitleText(
          title: "Mesarati MC20",
          smallSize: true,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        //price and sale price
        Row(
          children: [
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                "25%",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),

            //price
            Text(
              "LKR 250",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            const TVehiclePriceText(price: '175', isLarge: true)
          ],
        ),

        const SizedBox(
          width: TSizes.spaceBtwItems / 1.5,
        ),

        //stock status
        Row(
          children: [
            const TVehicleTitleText(title: "Status "),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              "Available",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems / 1.5,
        ),

        //brand
      ],
    );
  }
}
