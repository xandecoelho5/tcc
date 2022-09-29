import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomAppBar {
  CustomAppBar._();

  static final _boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: kBackgroundColor,
  );

  static _leadingIcon(context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 32, 8, 16),
      decoration: _boxDecoration,
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

  static _trailingIcon(context) {
    return Container(
      width: 34,
      margin: const EdgeInsets.fromLTRB(0, 32, 16, 16),
      decoration: _boxDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          borderRadius: BorderRadius.circular(8),
          child: const Icon(
            Icons.camera_alt_outlined,
            color: kBasicDarkColor,
            size: 18,
          ),
        ),
      ),
    );
  }

  static AppBar buildAppBar(BuildContext context, [String? title]) {
    return AppBar(
      title: title != null ? Text(title) : null,
      backgroundColor: kScaffoldColor,
      actions: [_trailingIcon(context)],
      leading: _leadingIcon(context),
      elevation: 0,
      toolbarHeight: 80,
    );
  }
}
