import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';
import 'package:karconnect/utils/theme/custom_themes/outlined_button_theme.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final OutlinedButtonThemeData outlinedButtonTheme = dark
        ? TOutlinedButtonTheme.darkOutlinedButtonTheme
        : TOutlinedButtonTheme.lightOutlinedButtonTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit))
        ], //profile picture change screen
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Center(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/car.jpg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ), // Add the retrieval URL from the DB
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace),
              Text(
                "username", // Retrieve the username from the DB
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              /// Profile Option
              const SizedBox(height: TSizes.defaultSpace * 2),
              buildProfileOption(
                context: context,
                icon: Iconsax.people,
                label: "Profile",
                onPressed: () {}, // Add path to profile screen
              ),

              /// Booking option
              const SizedBox(height: TSizes.defaultSpace * 0.1),
              buildProfileOption(
                context: context,
                icon: Iconsax.calendar,
                label: "Bookings",
                onPressed: () {}, // Add path to booking screen
              ),

              /// Wishlist
              const SizedBox(height: TSizes.defaultSpace * 0.1),
              buildProfileOption(
                context: context,
                icon: Iconsax.heart,
                label: "Wishlist",
                onPressed: () {}, // Add path to wishlist screen
              ),

              /// FAQs
              const SizedBox(height: TSizes.defaultSpace * 0.1),
              buildProfileOption(
                context: context,
                icon: Iconsax.message_question,
                label: "FAQs",
                onPressed: () {}, // Add path to FAQs screen
              ),

              /// Policy
              const SizedBox(height: TSizes.defaultSpace * 0.1),
              buildProfileOption(
                context: context,
                icon: Iconsax.document_text,
                label: "Policy",
                onPressed: () {}, // Add path to policy screen
              ),

              /// Settings
              const SizedBox(height: TSizes.defaultSpace * 0.1),
              buildProfileOption(
                context: context,
                icon: Iconsax.setting_2,
                label: "Settings",
                onPressed: () {}, // Add path to settings screen
              ),

              /// Help and Support
              const SizedBox(height: TSizes.defaultSpace * 0.1),
              buildProfileOption(
                context: context,
                icon: Iconsax.support,
                label: "Help and Support",
                onPressed: () {}, // Add path to help and support screen
              ),

              /// Rate Our App
              const SizedBox(height: TSizes.defaultSpace * 0.1),
              buildProfileOption(
                context: context,
                icon: Iconsax.like_1,
                label: "Rate our App",
                onPressed: () {}, // Add path to rate our app screen
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: TSizes.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white, width: 0.8),
          padding: const EdgeInsets.all(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(width: TSizes.defaultSpace),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
