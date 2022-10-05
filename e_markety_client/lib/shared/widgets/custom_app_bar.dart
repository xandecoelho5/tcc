import 'package:e_markety_client/shared/widgets/action_cart.dart';
import 'package:flutter/material.dart';

import '../theme/constants.dart';

class CustomAppBar {
  CustomAppBar._();

  static _leadingIcon(context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 32, 8, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kBackgroundColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.arrow_back_ios,
              color: kBasicDarkColor,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }

  static _title(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(title),
    );
  }

  static AppBar buildAppBar(
    BuildContext context, {
    String? title,
    TextStyle? titleStyle,
    Color? backgroundColor,
  }) {
    return AppBar(
      title: title != null ? _title(title) : null,
      backgroundColor: backgroundColor ?? kScaffoldColor,
      centerTitle: true,
      actions: const [ActionCart()],
      leading: _leadingIcon(context),
      titleTextStyle: titleStyle ??
          const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kBasicDarkColor,
          ),
    );
  }
}
