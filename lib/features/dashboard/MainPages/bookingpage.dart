import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              Tab(child: Text('Completed')),
              Tab(child: Text('Cancelled')),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Icon(Icons.upcoming, size: 350),
            Icon(Icons.done, size: 350),
            IconButton(
                onPressed: () => Get.toNamed('/details'),
                icon: Icon(
                  Icons.cancel,
                  size: 350,
                ))
          ],
        ),
      ),
    );
  }
}
