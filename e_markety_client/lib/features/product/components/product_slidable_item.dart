import 'package:e_markety_client/shared/extensions/double_extension.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';
import '../../../shared/widgets/slidable_card.dart';
import '../models/product.dart';

class ProductSlidableItem extends StatelessWidget {
  const ProductSlidableItem({
    Key? key,
    required this.product,
    required this.rightWidget,
    required this.onConfirmDelete,
  }) : super(key: key);

  final Product product;
  final Widget rightWidget;
  final VoidCallback onConfirmDelete;

  Padding _leftWidget() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Image.network(
              product.imageUrl,
              height: 75,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      product.finalPrice.toReal,
                      style: kLabelLarge.copyWith(color: kSecondaryColor),
                    ),
                    const SizedBox(width: 4),
                    if (product.hasPromotion)
                      Text(
                        product.price.toReal,
                        style: kLabelLarge.copyWith(
                          color: kDiscountColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                Text(
                  product.name,
                  style: kTitleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.formattedWeight,
                  style: kLabelLarge.copyWith(
                    color: Colors.grey.shade700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidableCard(
      valueKey: product.id!,
      onConfirmDelete: onConfirmDelete,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: kElevationToShadow[1],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 11,
              child: _leftWidget(),
            ),
            Expanded(
              flex: 2,
              child: rightWidget,
            ),
          ],
        ),
      ),
    );
  }
}
