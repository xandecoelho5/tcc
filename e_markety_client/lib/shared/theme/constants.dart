import 'package:flutter/material.dart';

const routes = [
  '/about-me',
  '/my-orders',
  '/favourite',
  '/address',
  '/add-new-address',
  '/home',
  '/sign-up',
  '/sign-in',
  '/category',
  '/search-result',
  '/products-by-category',
  '/product-details',
  '/shopping-cart',
  '/delivery-address',
  '/checkout',
  '/order-result',
  '/track-order',
  '/apply-filters',
];

const kPrimaryColor = Color(0xFFEB3E4B);
const kSecondaryColor = Color(0xFF2AC17E);
const kBasicDarkColor = Color(0xFF322C46);
const kBasicLightColor = Color(0xFFE9E9E9);
const kBackgroundColor = Color(0xFFFFFFFF);
const kScaffoldColor = Color(0xFFF5F5F5);

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
