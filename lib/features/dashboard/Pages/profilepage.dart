import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:karconnect/backend/data_fetch_and_represent/data_services/dataservice_from_collection.dart';
import 'package:karconnect/backend/firebase/firebase_auth.dart';
import 'package:karconnect/dummy_temp.dart';
import 'package:karconnect/features/authentication/screens/login/login.dart';
import 'package:karconnect/features/dashboard/Pages/subpages/rateUs.dart';
import 'package:karconnect/features/dashboard/Pages/view_bookings.dart';
import 'package:karconnect/features/dashboard/Pages/subpages/aboutus.dart';
import 'package:karconnect/utils/constants/sizes.dart';
import 'package:karconnect/utils/helpers/helper_functions.dart';
import 'package:karconnect/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String username = "";
  String? link;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final value = await CollectionDataService().get_user_data();
    setState(() {
      username = value?['username'] ?? "";
      link = value?['link'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final OutlinedButtonThemeData outlinedButtonTheme = dark
        ? TOutlinedButtonTheme.darkOutlinedButtonTheme
        : TOutlinedButtonTheme.lightOutlinedButtonTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("profile"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // profile Image
              Center(
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: TSizes.defaultSpace),
              Text(
                username,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              const SizedBox(height: TSizes.defaultSpace * 2),

              // profile Options
              _buildprofileOptions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildprofileOptions(BuildContext context) {
    return Column(
      children: [
        _buildprofileOption(
          context: context,
          icon: Iconsax.people,
          label: "profile",
          onPressed: () => Get.to(() => dummy()),
        ),
        _buildSpacedprofileOption(
          context: context,
          icon: Iconsax.calendar,
          label: "Bookings",
          onPressed: () => Get.to(() => const booking()),
        ),
        _buildSpacedprofileOption(
          context: context,
          icon: Iconsax.heart,
          label: "Wishlist",
          onPressed: () => Get.to(() => dummy()),
        ),
        _buildSpacedprofileOption(
          context: context,
          icon: Iconsax.message_question,
          label: "FAQs",
          onPressed: () => _launchURL('https://kangaroocabs.com/faq'),
        ),
        _buildSpacedprofileOption(
          context: context,
          icon: Iconsax.document_text,
          label: "Policy",
          onPressed: () =>
              _launchURL('https://kangaroocabs.com/terms-conditions'),
        ),
        _buildSpacedprofileOption(
          context: context,
          icon: Iconsax.setting_2,
          label: "Settings",
          onPressed: () => Get.to(() => dummy()),
        ),
        _buildSpacedprofileOption(
          context: context,
          icon: Iconsax.teacher,
          label: "About Us",
          onPressed: () => Get.to(() => AboutUsPage()),
        ),
        _buildSpacedprofileOption(
          context: context,
          icon: Iconsax.like_1,
          label: "Rate our App",
          onPressed: () => Get.to(() => RateUs()),
        ),
        _buildSpacedprofileOption(
          context: context,
          icon: Iconsax.logout,
          label: "Log out",
          onPressed: () => showSignOutDialog(context),
        ),
      ],
    );
  }

  Widget _buildSpacedprofileOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        const SizedBox(height: TSizes.defaultSpace * 0.1),
        _buildprofileOption(
          context: context,
          icon: icon,
          label: label,
          onPressed: onPressed,
        ),
      ],
    );
  }

  Widget _buildprofileOption({
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

  void showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(0, 95, 95, 95),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Center(child: _buildSignOutDialog(context)),
              ),
            ],
          ),
        );
      },
    );
  }

  CupertinoAlertDialog _buildSignOutDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Column(
        children: [
          Icon(
            CupertinoIcons.exclamationmark_circle,
            color: Color.fromARGB(255, 211, 55, 37),
            size: 120,
          ),
          SizedBox(width: 12),
          Text("Sign Out"),
        ],
      ),
      insetAnimationDuration: Durations.short3,
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        CupertinoDialogAction(
          onPressed: () async {
            Navigator.pop(context);
            try {
              signOut();
              Get.offAll(() => LoginScreen());
            } catch (e) {
              print("Error signing out: $e");
              // Handle the error appropriately
            }
          },
          child: const Text(
            "Confirm",
          ),
        ),
      ],
      content: const Column(
        children: [
          Text("Do you need to Sign out"),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // throw 'Could not launch $url';
    }
  }
}
