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
        fontSize = 14,
        iconSize = 32,
        imageHeight = 54,
        _isBig = false,
        super(key: key);

  const CategoryCard.big({
    Key? key,
    required this.category,
  })  : height = 200,
        fontSize = 18,
        iconSize = 40,
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
    final width = _isBig ? deviceWidth * 0.44 : 120.0;

    return GestureDetector(
      onTap: () => Modular.to.pushNamed(
        '/product/products-by-category',
        arguments: category,
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: kScaffoldColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: kElevationToShadow[3],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              width: width * 0.9,
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
              width: width,
              child: Container(
                height: imageHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  image: DecorationImage(
                    image: AssetImage(category.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              width: width * 0.75,
              top: _isBig ? 60 : 48,
              child: CategoryCircleAvatar(
                category: category,
                iconSize: iconSize,
                innerRadius: _isBig ? deviceWidth * 0.09 : deviceWidth * 0.065,
                outerRadius: _isBig ? deviceWidth * 0.10 : deviceWidth * 0.075,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
