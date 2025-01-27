import 'package:flutter/material.dart';

const Color mainBackground = Color(0xFF000620);
const Color textColor = Color(0xFFFE0CC2);
const Color secondaryTextColor = Color(0xFF356F93);
MaterialColor warningcolor = Colors.orange;
MaterialColor successcolor = Colors.green;
MaterialColor neutralColor = Colors.teal;
const Color defaultTextColor = Colors.white;
const gradientColours = [
  const Color.fromARGB(255, 20, 15, 78),
  const Color.fromARGB(255, 98, 52, 134),
  const Color.fromARGB(255, 22, 94, 101),
];
final ThemeData themdata = ThemeData(
  scaffoldBackgroundColor: mainBackground,
  primaryColor: mainBackground,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: mainBackground,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);
