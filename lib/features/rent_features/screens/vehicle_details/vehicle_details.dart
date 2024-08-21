import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:karconnect/backend/data_retrieve/brandCard_dynamic_list.dart';
import 'package:karconnect/common/widgets/appbar/appbar.dart';
import 'package:karconnect/common/widgets/custom_widgets/curved_edges/curved_edges_widget.dart';
import 'package:karconnect/common/widgets/custom_widgets/curved_edges/t_circular_icon.dart';
import 'package:karconnect/common/widgets/images/t_rounded_images.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/rent_specifications.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/vehicle_detail_image_slider.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/widgets/rating_share_widget.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/widgets/rent_owner_tab.dart';
import 'package:karconnect/features/rent_features/screens/vehicle_details/widgets/vehicle_meta_data.dart';
import 'package:karconnect/utils/constants/colors.dart';
import 'package:karconnect/utils/constants/image_strings.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/constants/text_strings.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class VehicleDetails extends StatelessWidget {
  final String VehicleName;
  final int price;
  final String owner;
  final String img_url;
  final String description;
  final VehicleID;
  const VehicleDetails(
    this.VehicleName,
    this.price,
    this.owner,
    this.img_url,
    this.description,
    this.VehicleID, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //vehicle image slider
              TVehicleImageSlider(img_url),

              //vehicle details
              Padding(
                padding: const EdgeInsets.only(
                    right: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace),
                child: Column(
                  children: [
                    //rating and share
                    const TRatingAndShare(),

                    //owner message call tab
                    TRentOwnerDetailsTab(owner),
                    const SizedBox(
                      height: TSizes.spaceBtwItems * 0.5,
                    ),

                    //price.title.stock brand
                    TVehicleMetaData(VehicleName, price),

                    //sttribute
                    Padding(
                      padding: EdgeInsets.only(left: 0, right: 30),
                      child: Text(
                        description,
                        // TTexts.yourAccountCreatedSubTitle,
                        maxLines: 3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        onTap: () => Get.to(() => RentSpecifications(
                              VehicleID: VehicleID,
                              Vehicle_model: VehicleName,
                              Price: price,
                            )),
                        child: const Row(
                          children: [
                            Text(
                              "View more",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 208, 128, 9),
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 12,
                                color: Color.fromARGB(
                                  255,
                                  208,
                                  128,
                                  9,
                                ))
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                        onTap: () => Get.to(() => RentSpecifications(
                              VehicleID: VehicleID,
                              Vehicle_model: VehicleName,
                              Price: price,
                            )),
                        child: const Row(
                          children: [
                            Text(
                              "Specifications",
                              style: TextStyle(fontSize: TSizes.fontSizeMd),
                            ),
                            SizedBox(
                              width: 130,
                            ),
                            Text(
                              "View more",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 208, 128, 9),
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 12,
                                color: Color.fromARGB(
                                  255,
                                  208,
                                  128,
                                  9,
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => Get.to(() => RentSpecifications(
                                  VehicleID: VehicleID,
                                  Vehicle_model: VehicleName,
                                  Price: price,
                                )),
                            child: Text("Rent Vehicle"))),
                    //checkoutbutton
                    //description
                    //reviewa
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
