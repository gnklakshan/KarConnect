import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class dummy extends StatelessWidget {
  const dummy({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text("dummy $uid"),
      ),
      body: Center(child: Text("Need To Design")),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:karconnect/backend/firebase/firebase_auth.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class dummy extends StatelessWidget {
//   const dummy({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text("dummy ")),
//       ),
//       // body: Center(child: Text("Need To Design")),
//       body: BookingConfirmationPage(
//         pickupDateTime: '26 Aug, 10:00',
//         pickupLocation: 'Colombo Downtown',
//         dropoffDateTime: '29 Aug, 10:00',
//         dropoffLocation: 'Colombo Downtown',
//         carPrice: 177.45,
//         carModel: 'Toyota Prius',
//         seats: 4,
//         transmission: 'Automatic',
//         largeBags: 1,
//         smallBags: 1,
//         unlimitedMileage: true,
//         driverIncluded: true,
//       ),
//     );
//   }
// }

// class BookingConfirmationPage extends StatelessWidget {
//   final String pickupDateTime;
//   final String pickupLocation;
//   final String dropoffDateTime;
//   final String dropoffLocation;
//   final double carPrice;
//   final String carModel;
//   final int seats;
//   final String transmission;
//   final int largeBags;
//   final int smallBags;
//   final bool unlimitedMileage;
//   final bool driverIncluded;

//   const BookingConfirmationPage({
//     Key? key,
//     required this.pickupDateTime,
//     required this.pickupLocation,
//     required this.dropoffDateTime,
//     required this.dropoffLocation,
//     required this.carPrice,
//     required this.carModel,
//     required this.seats,
//     required this.transmission,
//     required this.largeBags,
//     required this.smallBags,
//     required this.unlimitedMileage,
//     required this.driverIncluded,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Booking Summery',
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _SectionHeader('Pick-up and drop-off',
//                   icon: FontAwesomeIcons.mapMarkerAlt),
//               _DetailRow('Pick-up', '$pickupDateTime, $pickupLocation'),
//               _DetailRow('Drop-off', '$dropoffDateTime, $dropoffLocation'),
//               const SizedBox(height: 16),
//               _SectionHeader('Vehicle details', icon: FontAwesomeIcons.car),
//               _DetailRow('Car model', carModel),
//               _DetailRow('Seats', '$seats seats'),
//               _DetailRow('Transmission', transmission),
//               _DetailRow('Large bags', '$largeBags bags'),
//               _DetailRow('Small bags', '$smallBags bags'),
//               _DetailRow('Unlimited mileage', unlimitedMileage ? 'Yes' : 'No'),
//               _DetailRow('Baby Seat', driverIncluded ? 'Yes' : 'No'),
//               const SizedBox(height: 16),
//               _SectionHeader('Vehicle price breakdown',
//                   icon: FontAwesomeIcons.moneyBillAlt),
//               _DetailRow(
//                   'Car hire charge', '\Rs ${carPrice.toStringAsFixed(2)}'),
//               _DetailRow('Total price', '\Rs ${carPrice.toStringAsFixed(2)}'),
//               const SizedBox(height: 16),
//               const SizedBox(height: 16),
//               _PaymentInstructions(),
//               const SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     print('Confirmed booking');
//                   },
//                   child: const Text('Confirm Booking'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SectionHeader extends StatelessWidget {
//   final String text;
//   final IconData? icon;

//   const _SectionHeader(this.text, {this.icon, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       children: [
//         if (icon != null) ...[
//           Icon(icon, size: 20, color: theme.colorScheme.secondary),
//           const SizedBox(width: 8),
//         ],
//         Text(
//           text,
//           style: theme.textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _DetailRow extends StatelessWidget {
//   final String label;
//   final String value;

//   const _DetailRow(this.label, this.value, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: theme.textTheme.bodyMedium),
//           Text(value, style: theme.textTheme.bodyMedium),
//         ],
//       ),
//     );
//   }
// }

// class _PaymentInstructions extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;

//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: isDarkMode
//             ? theme.colorScheme.primary.withOpacity(0.1)
//             : Color.fromARGB(196, 182, 236, 182),
//         border: Border.all(
//           color: isDarkMode
//               ? theme.colorScheme.primary
//               : Color.fromARGB(126, 14, 14, 14),
//           width: 2.0,
//         ),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Payment Instructions',
//             style: theme.textTheme.titleMedium?.copyWith(
//               fontWeight: FontWeight.bold,
//               color: theme.colorScheme.primary,
//             ),
//           ),
//           const SizedBox(height: 12.0),
//           RichText(
//             text: TextSpan(
//               children: [
//                 TextSpan(
//                   text:
//                       'To confirm your booking, please pay \Rs 1,000 (non-refundable) to the following account:\n\n',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: theme.colorScheme.onBackground,
//                   ),
//                 ),
//                 TextSpan(
//                   text: 'Account number: 15555455\n',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: theme.colorScheme.primary,
//                   ),
//                 ),
//                 TextSpan(
//                   text: 'Bank: Bank of Ceylon (BOC)\n\n',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                     color: theme.colorScheme.primary,
//                   ),
//                 ),
//                 TextSpan(
//                   text: 'See your email for more details.',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     color: theme.colorScheme.onBackground,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
