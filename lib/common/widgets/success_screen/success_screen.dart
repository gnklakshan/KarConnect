import 'package:karconnect/common/styles/spacing_styles.dart';
import 'package:karconnect/utils/constants/image_strings.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/constants/text_strings.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          //          padding: TSpacingStyles.paddigWithAppBarHeight * 2,

          padding: TSpacingStyles.paddigWithAppBarHeight,
          child: Column(
            children: [
              Image(
                image: const AssetImage(TImages.verifyIllustration),
                // width: THelperFunctions.screenWidth(context) * 0.6,
              ),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //tiitile and subtitile
              Text(
                TTexts.confirmEmail,
                // style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                ("email here"),
                // style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                TTexts.confirmEmailSubTitle,
                // style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
