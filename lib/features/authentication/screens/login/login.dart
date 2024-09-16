import 'package:karconnect/common/styles/spacing_styles.dart';
import 'package:karconnect/common/widgets/login_signup/form_divider.dart';
import 'package:karconnect/common/widgets/login_signup/social_buttons.dart';
import 'package:karconnect/features/authentication/screens/login/widgets/login_form.dart';
import 'package:karconnect/features/authentication/screens/login/widgets/login_header.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/constants/text_strings.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddigWithAppBarHeight,
          child: Column(
            children: [
              const TLoginHeader(),

              const TLoginForm(),

              ///Divider
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(
                width: TSizes.spaceBtwSections,
              ),
              SizedBox(height: 0.5 * TSizes.spaceBtwSections),

              //footer
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
