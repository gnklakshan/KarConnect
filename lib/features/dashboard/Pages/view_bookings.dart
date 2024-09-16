import 'package:flutter/material.dart';
import 'package:karconnect/backend/data_fetch_and_represent/booked_card_dynamic_list.dart';

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
