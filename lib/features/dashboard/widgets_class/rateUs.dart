import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karconnect/features/dashboard/dashbord.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rating_dialog/rating_dialog.dart';

class RateUs extends StatefulWidget {
  const RateUs({Key? key}) : super(key: key);

  @override
  State<RateUs> createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Container(
          color: Color.fromARGB(88, 181, 171, 171),
          child: RatingDialog(
            initialRating: 1.0,
            title: const Text(
              'Rate Us',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            message: const Text(
              'Tap a star to rate. Feel free to add a description for more details.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            image: const Icon(
              Icons.star,
              size: 100,
              color: Colors.amber,
            ),
            submitButtonText: 'Submit',
            commentHint: 'Add your valuable comment here',
            onCancelled: (() => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => dashboard()),
                )),
            onSubmitted: (response) {
              print('rating: ${response.rating}, comment: ${response.comment}');

              // if (response.rating < 3.0) {
              //   // Handle low rating case
              // } else {
              //   _launchUrl();
              // }
              Get.to(() => dashboard());
            },
          ),
        ),
      );
    });

    return SizedBox.shrink();
  }

  void _launchUrl() async {
    const url = 'https://yoururl.com'; // Replace with your URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
