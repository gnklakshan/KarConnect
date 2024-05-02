import 'package:get/get.dart';
import 'package:karconnect/app.dart';

class RouteClass {
  static final routes = [
    GetPage(
        name: '/', page: () => const MyHomePage(title: ' Demo signup Page')),
    // GetPage(name: '/addPage', page: () => AddPage()),
    // GetPage(name: '/secondpage', page: () => SecondPage()),
  ];

  static String getHomeRoute() {
    return '/';
  }
}
