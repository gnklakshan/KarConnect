import 'package:flutter/material.dart';
import 'package:karconnect/features/dashboard/MainPages/bookingpage.dart';
import 'package:karconnect/features/dashboard/MainPages/homepage.dart';
import 'package:karconnect/features/dashboard/MainPages/massagepage.dart';
import 'package:karconnect/features/dashboard/MainPages/profilepage.dart';
import 'package:karconnect/utils/theme/theme.dart'; // Import your custom theme

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    booking(),
    explore(),
    profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    final ThemeData lightTheme = TAppTheme.lightTheme;
    final ThemeData darkTheme = TAppTheme.darkTheme;

    return Theme(
      data: isDarkMode ? darkTheme : lightTheme,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 24,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor:
              isDarkMode ? darkTheme.primaryColor : lightTheme.primaryColor,
          unselectedItemColor: isDarkMode
              ? darkTheme.unselectedWidgetColor
              : lightTheme.unselectedWidgetColor,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
