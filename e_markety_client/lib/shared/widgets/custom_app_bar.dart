import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../theme/constants.dart';
import 'action_cart.dart';

class CustomAppBar {
  CustomAppBar._();

  static Container _leadingIcon(context, onLeadingTap) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 8, 8),
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

  static Padding _title(title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(title),
    );
  }

  static AppBar buildAppBar(
    BuildContext context, {
    String? title,
    TextStyle? titleStyle,
    Color? backgroundColor,
    Function()? onLeadingTap,
    bool showAction = true,
  }) {
    return AppBar(
      title: title != null ? _title(title) : null,
      backgroundColor: backgroundColor ?? kScaffoldColor,
      centerTitle: true,
      actions: showAction ? [const ActionCart()] : [],
      leading: _leadingIcon(context, onLeadingTap),
      titleTextStyle: titleStyle ??
          const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kBasicDarkColor,
          ),
    );
  }
}
