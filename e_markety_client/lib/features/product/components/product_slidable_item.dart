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
                Text(
                  '\$${product.finalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor,
                  ),
                ),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.formattedWeight,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
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
