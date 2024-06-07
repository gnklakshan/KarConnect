import 'package:karconnect/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:karconnect/features/authentication/screens/Onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:karconnect/features/authentication/screens/Onboarding/widgets/onboarding_page.dart';
import 'package:karconnect/features/authentication/screens/Onboarding/widgets/onboarding_skip.dart';
import 'package:karconnect/utils/constants/colors.dart';
import 'package:karconnect/utils/constants/image_strings.dart';
import 'package:karconnect/utils/constants/text_strings.dart';
import 'package:karconnect/utils/device/device_utility.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          //horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.OnBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.OnBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              // OnBoardingPage(
              //   image: TImages.OnBoardingImage3,
              //   title: TTexts.onBoardingTitle3,
              //   subTitle: TTexts.onBoardingSubTitle3,
              // ),
            ],
          ),
          const OnBoardingSkip(),
          const OnboardingDotNavigation(),
          OnBoardingNextButton(),
        ],
      ),
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
        right: TSizes.defaultSpace,
        bottom: DeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
          //////////
          onPressed: () => OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: dark ? TColors.primary : Colors.black),
          child: const Icon(Iconsax.arrow_right),
        ));
  }
}
