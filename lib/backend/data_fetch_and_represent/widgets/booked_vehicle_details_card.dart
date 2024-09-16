import 'package:flutter/material.dart';

//  booking tab summery card-------------------------------------------------------------------------------------------

class VehicleBookedCard extends StatelessWidget {
  final String imageUrl;
  final String vehicleName;
  final int pricePerDay;
  final String startDateTime;
  final String endDateTime;

  // Constructor with required parameters
  VehicleBookedCard({
    required this.imageUrl,
    required this.vehicleName,
    required this.pricePerDay,
    required this.startDateTime,
    required this.endDateTime,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 5,
      color: isDarkMode
          ? const Color.fromARGB(255, 31, 31, 31) // Color for dark mode
          : Colors.white,
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Vehicle image and details
          Stack(
            children: [
              Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicleName,
                      style: textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: List.empty(),
                      ),
                    ),
                    Text(
                      'Rs $pricePerDay / Day',
                      style: textTheme.headlineSmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Booking details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDetailRow(
                    'Starting Date & Time', startDateTime, textTheme),
                _buildDetailRow('Ending Date & Time', endDateTime, textTheme),
              ],
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 194, 53, 53),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shadowColor: const Color.fromARGB(255, 243, 33, 166),
                    elevation: 1,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('View'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
