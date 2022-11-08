import 'package:e_markety_client/features/category/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/widgets/category_circle_avatar.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard.small({
    Key? key,
    required this.category,
  })  : height = 140,
        fontSize = 12,
        iconSize = 36,
        imageHeight = 54,
        _isBig = false,
        super(key: key);

  const CategoryCard.big({
    Key? key,
    required this.category,
  })  : height = 200,
        fontSize = 18,
        iconSize = 45,
        imageHeight = 86,
        _isBig = true,
        super(key: key);

  final bool _isBig;
  final Category category;
  final double height;
  final double fontSize;
  final double iconSize;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final width = _isBig ? deviceWidth * 0.43 : 120.0;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        child: InkWell(
          splashColor: category.color,
          onTap: () => Modular.to.pushNamed(
            '/products-by-category',
            arguments: category,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                width: width * 0.9, //100
                top: 12,
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w700,
                    color: category.color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                bottom: 0,
                width: width, //120
                child: Container(
                  height: imageHeight,
                  color: Colors.white,
                  child: Image.asset(category.imageUrl, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                width: width * 0.75, //90
                top: _isBig ? 65 : 48,
                child: CategoryCircleAvatar(
                  category: category,
                  iconSize: iconSize,
                  innerRadius:
                      _isBig ? deviceWidth * 0.09 : deviceWidth * 0.065,
                  outerRadius:
                      _isBig ? deviceWidth * 0.10 : deviceWidth * 0.075,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
