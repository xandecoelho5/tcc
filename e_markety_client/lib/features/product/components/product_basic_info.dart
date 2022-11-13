import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/extensions/double_extension.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';
import 'category_chip.dart';

class ProductBasicInfo extends StatelessWidget {
  const ProductBasicInfo({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryChip.big(
            label: product.category!.name,
            color: product.category!.color,
          ),
          const SizedBox(height: 4),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            product.formattedWeight,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                product.finalPrice.toReal,
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              if (product.hasPromotion)
                Text(
                  product.price.toReal,
                  style: const TextStyle(
                    color: kDiscountColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
