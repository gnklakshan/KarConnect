import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Card(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        surfaceTintColor: isDarkMode ? Colors.blueGrey : Colors.blue,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    ' Notifications',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return const NotificationCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDarkMode
          ? Colors.grey[800]
          : const Color.fromARGB(237, 255, 255, 255),
      child: const ListTile(
        leading: CircleAvatar(
          backgroundColor: Color.fromARGB(255, 193, 234, 193),
          child: Icon(
            Iconsax.tick_circle,
            color: Color.fromARGB(255, 17, 203, 95),
          ),
        ),
        title: Text(
          'Loggin success',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('You have successfully logged in'),
        trailing: Text(
          '1s ago',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
