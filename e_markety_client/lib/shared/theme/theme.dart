import 'package:flutter/material.dart';

import 'constants.dart';

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
    bodyColor: kBasicDarkColor,
    displayColor: kBasicDarkColor,
  ),
  scaffoldBackgroundColor: kScaffoldColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: kScaffoldColor,
    elevation: 0,
    toolbarHeight: 80,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: kOutlineInputBorder,
    focusedBorder: kOutlineInputBorder,
    enabledBorder: kOutlineInputBorder,
    errorBorder: kErrorOutlineInputBorder,
    focusedErrorBorder: kErrorOutlineInputBorder,
  ),
);
