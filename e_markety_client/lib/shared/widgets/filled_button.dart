import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.height,
    this.width,
  }) : super(key: key);

  final Color color;
  final String text;
  final Function()? onPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? double.infinity, height ?? 70),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(text, style: kHeadline6Light.copyWith(letterSpacing: -0.5)),
    );
  }
}
