import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFEB3E4B);
const kSecondaryColor = Color(0xFF2AC17E);
const kBasicDarkColor = Color(0xFF322C46);
const kBasicLightColor = Color(0xFFE9E9E9);
const kBackgroundColor = Color(0xFFFFFFFF);
const kScaffoldColor = Color(0xFFF5F5F5);

const kTesteColor = Colors.deepPurple;

final kThemeData = ThemeData(
  fontFamily: 'Raleway',
  colorScheme: const ColorScheme.light().copyWith(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: kTesteColor,
    displayColor: kTesteColor,
  ),
  scaffoldBackgroundColor: kScaffoldColor,
);
