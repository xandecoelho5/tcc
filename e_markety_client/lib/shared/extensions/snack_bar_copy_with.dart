import 'package:flutter/material.dart';

extension SnackBarCopyWith on SnackBar {
  SnackBar copyWith({
    Key? key,
    Widget? content,
    SnackBarAction? action,
    Color? backgroundColor,
    double? elevation,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    ShapeBorder? shape,
    SnackBarBehavior? behavior,
    Duration? duration,
    Animation<double>? animation,
  }) {
    return SnackBar(
      key: key ?? this.key,
      content: content ?? this.content,
      action: action ?? this.action,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      elevation: elevation ?? this.elevation,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      shape: shape ?? this.shape,
      behavior: behavior ?? this.behavior,
      duration: duration ?? this.duration,
      animation: animation ?? this.animation,
    );
  }
}
