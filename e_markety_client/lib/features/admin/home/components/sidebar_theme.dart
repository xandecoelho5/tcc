import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SidebarTheme {
  SidebarTheme._();

  static SidebarXTheme build() {
    return SidebarXTheme(
      margin: const EdgeInsets.only(top: 40),
      hoverColor: accentCanvasColor.withOpacity(0.2),
      textStyle: TextStyle(color: textColor),
      selectedTextStyle: const TextStyle(color: selectedTextColor),
      itemTextPadding: const EdgeInsets.only(left: 10),
      selectedItemTextPadding: const EdgeInsets.only(left: 10),
      itemDecoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      selectedItemDecoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [accentCanvasColor, accentCanvasColor],
        ),
        boxShadow: [
          BoxShadow(
            color: accentCanvasColor.withOpacity(0.28),
            blurRadius: 15,
          )
        ],
      ),
      iconTheme: IconThemeData(
        color: textColor,
        size: 20,
      ),
      selectedIconTheme: const IconThemeData(
        color: selectedTextColor,
        size: 20,
      ),
      selectedItemMargin: EdgeInsets.zero,
      itemMargin: EdgeInsets.zero,
    );
  }

  static SidebarXTheme buildExtended() {
    return const SidebarXTheme(
      margin: EdgeInsets.only(top: 5),
      width: 200,
      decoration: BoxDecoration(
        color: canvasColor,
        border: Border(right: BorderSide(color: Colors.grey, width: 0.5)),
      ),
    );
  }
}

final textColor = Colors.blueGrey.withOpacity(0.9);
const selectedTextColor = Colors.white;
const canvasColor = Colors.white;
const scaffoldBackgroundColor = Colors.white;
const accentCanvasColor = kPrimaryColor;
