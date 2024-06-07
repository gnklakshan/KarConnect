import 'package:karconnect/common/widgets/appbar/appbar.dart';
import 'package:karconnect/common/widgets/custom_widgets/curved_edges/curved_edges_widget.dart';
import 'package:karconnect/common/widgets/custom_widgets/curved_edges/t_circular_icon.dart';
import 'package:karconnect/common/widgets/images/t_rounded_images.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/vehicle_detail_image_slider.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/widgets/rating_share_widget.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/widgets/vehicle_meta_data.dart';
import 'package:karconnect/utils/constants/colors.dart';
import 'package:karconnect/utils/constants/image_strings.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class VehicleDetails extends StatelessWidget {
  const VehicleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //vehicle image slider
            TVehicleImageSlider(),

            //vehicle details
            Padding(
              padding: EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  //rating and share
                  TRatingAndShare(),
                  //price.title.stock brand
                  TVehicleMetaData()
                  //sttribute
                  //checkoutbutton
                  //description
                  //reviewa
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
