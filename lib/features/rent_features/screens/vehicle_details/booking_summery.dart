import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:karconnect/backend/data_store/book_vehicle_backend.dart';

import '../../../dashboard/dashbord.dart';

class BookingConfirmationPage extends StatelessWidget {
  final String VehicleID;
  final String pickupDateTime;
  final String pickupLocation;
  final String dropoffDateTime;
  final String dropoffLocation;
  final int carPrice;
  final String carModel;
  final int seats;
  final String transmission;
  final int largeBags;
  final int smallBags;
  final bool unlimitedMileage;
  final bool driverIncluded;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;

  const BookingConfirmationPage(
      {Key? key,
      required this.VehicleID,
      required this.pickupDateTime,
      required this.pickupLocation,
      required this.dropoffDateTime,
      required this.dropoffLocation,
      required this.carPrice,
      required this.carModel,
      required this.seats,
      required this.transmission,
      required this.largeBags,
      required this.smallBags,
      required this.unlimitedMileage,
      required this.driverIncluded,
      required this.startDate,
      required this.startTime,
      required this.endDate,
      required this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Booking Summery',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader('Pick-up and drop-off',
                  icon: FontAwesomeIcons.mapMarkerAlt),
              _DetailRow('Pick-up', '$pickupDateTime, $pickupLocation'),
              _DetailRow('Drop-off', '$dropoffDateTime, $dropoffLocation'),
              const SizedBox(height: 16),
              _SectionHeader('Vehicle details', icon: FontAwesomeIcons.car),
              _DetailRow('Car model', carModel),
              _DetailRow('Seats', '$seats seats'),
              _DetailRow('Transmission', transmission),
              _DetailRow('Large bags', '$largeBags bags'),
              _DetailRow('Small bags', '$smallBags bags'),
              _DetailRow('Unlimited mileage', unlimitedMileage ? 'Yes' : 'No'),
              _DetailRow('Baby Seat', driverIncluded ? 'Yes' : 'No'),
              const SizedBox(height: 16),
              _SectionHeader('Vehicle price breakdown',
                  icon: FontAwesomeIcons.moneyBillAlt),
              _DetailRow(
                  'Car hire charge', '\Rs ${carPrice.toStringAsFixed(2)}'),
              _DetailRow('Service Charge', '\Rs ${2500.toStringAsFixed(2)}'),
              _DetailRow(
                  'Total price', '\Rs ${(carPrice + 2500).toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              _PaymentInstructions(),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print('Confirmed booking');
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Color.fromARGB(0, 218, 214, 214),
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                child: AlertBox(
                                  VehicleID: VehicleID,
                                  startDate: startDate,
                                  startTime: startTime,
                                  endDate: endDate,
                                  endTime: endTime,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Confirm Booking'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  final IconData? icon;

  const _SectionHeader(this.text, {this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: theme.colorScheme.secondary),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Text(value, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _PaymentInstructions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDarkMode
            ? theme.colorScheme.primary.withOpacity(0.1)
            : Color.fromARGB(196, 182, 236, 182),
        border: Border.all(
          color: isDarkMode
              ? theme.colorScheme.primary
              : Color.fromARGB(126, 14, 14, 14),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Instructions',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      'To confirm your booking, please pay \Rs 1,000 (non-refundable) to the following account:\n\n',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                TextSpan(
                  text: 'Account number: 15555455\n',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                TextSpan(
                  text: 'Bank: Bank of Ceylon (BOC)\n\n',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                TextSpan(
                  text: 'See your email for more details.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AlertBox extends StatelessWidget {
  final String VehicleID;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  const AlertBox(
      {super.key,
      required this.VehicleID,
      required this.startDate,
      required this.startTime,
      required this.endDate,
      required this.endTime});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: [
          Icon(
            CupertinoIcons.check_mark_circled,
            color: CupertinoColors.activeGreen,
            size: 120,
          ),
          SizedBox(width: 12),
          Text("Confirm Booking"),
        ],
      ),
      insetAnimationDuration: Durations.short3,
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text("Cancel"),
        ),
        CupertinoDialogAction(
            onPressed: () {
              addRentedVehicle(
                  VehicleID, startDate, endDate, startTime, endTime);
              RentedVehicleList(
                  VehicleID, startDate, endDate, startTime, endTime);
              updateVehicleAvailability(VehicleID);
              Navigator.pop(context); // Close the dialog
              Get.to(() => dashboard());
              // Navigator.pop(context); // Close the dialog
            },
            child: Text("Confirm")),
      ],
      content: Column(
        children: [
          Text(
            "Are you sure you want to book the vehicle for $startDate $startTime to $endDate $endTime?",
          ),
        ],
      ),
    );
  }
}
