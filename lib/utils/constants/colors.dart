import 'dart:ui';

import 'package:flutter/material.dart';

class TColors {
  TColors._();

  static const Color primary = Color(0xFF4b68ff);
  static const Color secondary = Color(0xFFFFE248);
  static const Color accent = Color(0xFFb0c7ff);

  //gradient colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4), Color(0xFFFAD0C4)],
  );

  static const Color textPrimary = Color(0x333333);
  static const Color textSecondary = Color(0x6C7570);
  static const Color textwhite = Colors.white;

  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = Colors.white.withOpacity(0.1);

  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondaryColor = Color(0xFF6C7570);
  static const Color buttonDisabledColor = Color(0xFFC4C4C4);

  // Border Colors
  static const Color borderPrimaryColor = Color(0xFFD90909);
  static const Color borderSecondaryColor = Color(0xFFE6E6E6);

  // Error and Validation Colors
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF57C00);
  static const Color infoColor = Color(0xFF197602);

  // Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
}
