import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../theme/constants.dart';
import 'action_cart.dart';

class CustomAppBar {
  CustomAppBar._();

  static Container leadingIcon(Function()? onLeadingTap) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 8, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kBackgroundColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onLeadingTap ?? () => Modular.to.pop(),
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

  static AppBar buildAppBar({
    String? title,
    TextStyle? titleStyle,
    Color? backgroundColor,
    Function()? onLeadingTap,
    bool showAction = true,
    bool showLeading = true,
  }) {
    return AppBar(
      title: title != null ? Text(title) : null,
      backgroundColor: backgroundColor ?? kScaffoldColor,
      centerTitle: true,
      actions: showAction ? [const ActionCart()] : [],
      leading: showLeading ? leadingIcon(onLeadingTap) : null,
      titleTextStyle: titleStyle ?? kHeadline6Dark,
    );
  }
}
