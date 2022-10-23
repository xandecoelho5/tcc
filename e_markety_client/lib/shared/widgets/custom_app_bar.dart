import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../theme/constants.dart';

class CustomAppBar {
  CustomAppBar._();

  static Container _leadingIcon(context, onLeadingTap) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 32, 8, 16),
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
  }) {
    return AppBar(
      title: title != null ? _title(title) : null,
      backgroundColor: backgroundColor ?? kScaffoldColor,
      centerTitle: true,
      actions: [
        // const ActionCart(),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: kBasicDarkColor),
          onSelected: (String item) => Modular.to.pushNamed(item),
          itemBuilder: (BuildContext context) => routes.map((String item) {
            return PopupMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
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
