import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFEB3E4B);
const kSecondaryColor = Color(0xFF2AC17E);
const kBasicDarkColor = Color(0xFF322C46);
// const kBasicDarkColor = Colors.purpleAccent;
const kBasicLightColor = Color(0xFFE9E9E9);
const kBackgroundColor = Color(0xFFF5F5F5);
const kScaffoldColor = Colors.white;

const kWeakSecondaryColor = Color(0XFFCEF7E4);

const kGreenColor = Color(0XFF4CA64C);
const kLightBrownColor = Color(0xFFD39447);
const kMediumBrownColor = Color(0xFF7E724C);
const kBrownColor = Color(0xFFB34F2D);
const kGreyColor = Color(0xFF646A8A);
const kPurpleColor = Color(0XFF945DA1);
const kBlueColor = Color(0XFF2788BB);
const kPinkColor = Color(0XFFF2598D);
const kLightGreyColor = Color(0XFF787161);
const kWeakBrownColor = Color(0XFFB7823C);
const kGoogleColor = Color(0XFFEA4335);
const kFacebookColor = Color(0XFF3B5998);
final kDarkGreyColor = Colors.grey.shade600;
const kDiscountColor = Color(0XFFCEB35C);
const kLabelColor = Color(0XFF8a909d);

const kBorderRadius = BorderRadius.all(Radius.circular(8));

const kOutlineInputBorder = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: BorderSide(color: kBackgroundColor),
);

const kErrorOutlineInputBorder = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: BorderSide(color: Colors.red),
);

const kBottomRadiusCircularBorder = BorderRadius.only(
  bottomLeft: Radius.circular(10),
  bottomRight: Radius.circular(10),
);

const kDecorationBottomRadiusCircularBorder = BoxDecoration(
  color: Colors.white,
  borderRadius: kBottomRadiusCircularBorder,
);

final kDivider = Divider(color: Colors.grey.withOpacity(0.3), height: 1);

final kTextInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: Color(0XFFEEEEEE)),
);

final kTextInputDecoration = InputDecoration(
  enabledBorder: kTextInputBorder,
  focusedBorder: kTextInputBorder,
  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
  errorBorder: kTextInputBorder.copyWith(
    borderSide: BorderSide(color: Colors.red.shade700),
  ),
  focusedErrorBorder: kTextInputBorder.copyWith(
    borderSide: BorderSide(color: Colors.red.shade700),
  ),
);

const kLabelLarge = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

final kLabelLargeDark = kLabelLarge.copyWith(color: kBasicDarkColor);

final kLabelLargeLight = kLabelLarge.copyWith(color: kScaffoldColor);

const kTitleRegular = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: Colors.white,
);

const kTitleMedium = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

final kTitleMediumDark = kTitleMedium.copyWith(color: kBasicDarkColor);

final kTitleMediumLight = kTitleMedium.copyWith(color: kScaffoldColor);

const kTitleLarge = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

final kTitleLargeDark = kTitleLarge.copyWith(color: kBasicDarkColor);

final kTitleLargeLight = kTitleLarge.copyWith(color: kScaffoldColor);

const kHeadline6 = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

final kHeadline6Dark = kHeadline6.copyWith(color: kBasicDarkColor);

final kHeadline6Light = kHeadline6.copyWith(color: kScaffoldColor);

// specific use
final kHomeAddressStyle = TextStyle(
  fontSize: 10,
  color: Colors.grey.shade500,
  fontWeight: FontWeight.bold,
);
