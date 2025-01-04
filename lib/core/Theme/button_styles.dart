import 'package:flutter/material.dart';
import 'package:tactix_academy_players/core/Theme/appcolours.dart';

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: textColor, // Background color
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0), // Rounded corners
  ),
  padding: const EdgeInsets.symmetric(
      vertical: 10.0, horizontal: 10.0), // Button padding
);
