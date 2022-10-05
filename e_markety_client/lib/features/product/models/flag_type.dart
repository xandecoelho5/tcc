import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';

enum FlagType {
  newProduct('NEW', Color(0XFFF9E9C8), Colors.brown),
  promotion('xx %', Color(0XFFEBDAFE), kPurpleColor),
  inStock('In Stock', Color(0XFFCEF7E4), kSecondaryColor),
  outOfStock('Out of Stock', Color(0XFFFA8989), kPrimaryColor);

  const FlagType(this.label, this.backgroundColor, this.foregroundColor);

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
}
