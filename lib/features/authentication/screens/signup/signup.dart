import 'package:karconnect/common/widgets/login_signup/form_divider.dart';
import 'package:karconnect/common/widgets/login_signup/social_buttons.dart';
import 'package:karconnect/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:karconnect/utils/constants/colors.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/constants/text_strings.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(
              TTexts.signupTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //Form
            const TSignupForm(),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            //divider
            TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            //social buttons
            const TSocialButtons(),
          ],
        ),
      )),
    );
  }
}
