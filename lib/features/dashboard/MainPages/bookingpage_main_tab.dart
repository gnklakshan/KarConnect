import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karconnect/features/dashboard/widgets_class/book_details_card.dart';

import '../../../backend/data_retrieve/booked_card_dynamic_list.dart';

class booking extends StatelessWidget {
  const booking({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
              child: Text(
            'Booking',
            style: TextStyle(
              fontSize: 18.0,
            ),
          )),
          bottom: const TabBar(
            isScrollable: false,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            tabs: [
              Tab(child: Text('Upcoming')),
              Tab(child: Text('Confirmed')),
              Tab(child: Text('Cancelled')),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            VehicleBookedList(
              type: 'pending',
              icon_name: Icon(Icons.upcoming, size: 350),
            ),
            VehicleBookedList(
              type: 'confirm',
              icon_name: Icon(Icons.done, size: 350),
            ),
            VehicleBookedList(
              type: 'cancel',
              icon_name: Icon(
                Icons.cancel,
                size: 350,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class VehicleBookedList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 1,
//       itemBuilder: (context, index) {
//         return VehicleBookedCard(
//           imageUrl: 'assets/images/car.jpg',
//           vehicleName: 'Suzuki Swift - 2017 Model',
//           pricePerDay: 'Rs 1500 / Day',
//           startDateTime: 'Feb 14 | 10:00 AM',
//           endDateTime: 'Feb 16 | 05:00 PM',
//           deliveryLocation: '28/6, Trustpuram, Kodambakkam, Chennai-24',
//           returnLocation: '28/6, Trustpuram, Kodambakkam, Chennai-24',
//         );
//       },
//     );
//   }
// }
