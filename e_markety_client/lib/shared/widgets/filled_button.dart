import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  const FilledButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.height,
  }) : super(key: key);

  final Color color;
  final String text;
  final Function()? onPressed;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, height ?? 70),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(text, style: kHeadline6Light.copyWith(letterSpacing: -0.5)),
    );
  }
}
