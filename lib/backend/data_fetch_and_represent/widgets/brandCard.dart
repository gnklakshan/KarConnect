import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karconnect/dummy_temp.dart';

Card BrandCard(BuildContext context, String name, String path) {
  final theme = Theme.of(context);

  return Card(
    color: theme.scaffoldBackgroundColor, // theme's card color
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        color: theme.dividerColor
            .withOpacity(0.3), // theme's divider color with opacity
        width: 1,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        // onTap: () => Get.to(() => const dummy()),
        child: Column(
          children: [
            Image.network(
              path,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ),
  );
}
