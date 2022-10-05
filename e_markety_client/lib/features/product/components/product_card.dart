import 'package:e_markety_client/features/product/components/category_chip.dart';
import 'package:e_markety_client/features/product/components/product_flag_widget.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';

import '../models/flag_type.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  _buildPromotionOrNewFlag() {
    return Positioned(
      top: 10,
      left: 0,
      child: ProductFlagWidget.small(
        flagType:
            product.hasPromotion ? FlagType.promotion : FlagType.newProduct,
        promotionPercentage: product.promotionPercent,
      ),
    );
  }

  _buildFavoriteFlag() {
    return Positioned(
      top: 6,
      right: 5,
      child: Icon(
        product.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: product.isFavorite ? kSecondaryColor : Colors.grey.shade300,
      ),
    );
  }

  _buildCartButton() {
    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        heroTag: product.name,
        backgroundColor: kPrimaryColor,
        mini: true,
        elevation: 10,
        onPressed: () {},
        child: const Icon(
          Icons.add_shopping_cart,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  _productInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.grey.withOpacity(0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.imageUrl,
                  height: 145,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: CategoryChip.small(label: product.category.name),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    product.formattedWeight,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2, left: 12),
            child: Text(
              '\$${product.finalValue.toStringAsFixed(2)}',
              style: const TextStyle(
                color: kSecondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 265,
        width: MediaQuery.of(context).size.width * 0.44,
        child: Stack(
          children: [
            _productInfo(),
            if (product.hasPromotion || product.isNew)
              _buildPromotionOrNewFlag(),
            _buildFavoriteFlag(),
            _buildCartButton(),
          ],
        ),
      ),
    );
  }
}
