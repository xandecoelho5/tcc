import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    this.style,
    this.moreStyle,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final TextStyle? moreStyle;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: 5,
      colorClickableText: Colors.pink,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Mostrar mais',
      trimExpandedText: 'Mostrar menos',
      style: style,
      moreStyle: moreStyle,
    );
  }
}
