import 'package:e_markety_client/features/product/components/product_basic_info.dart';
import 'package:e_markety_client/features/product/components/product_flag_widget.dart';
import 'package:e_markety_client/features/product/components/product_quantity.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:e_markety_client/shared/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../models/flag_type.dart';
import 'accordion.dart';
import 'favourite_icon.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    Key? key,
    required this.product,
    required this.onQuantityChanged,
  }) : super(key: key);

  final Product product;
  final void Function(double) onQuantityChanged;

  Positioned _buildStockFlag() {
    return Positioned(
      top: 10,
      left: 0,
      child: ProductFlagWidget.big(
        flagType: product.stock > 0 ? FlagType.inStock : FlagType.outOfStock,
      ),
    );
  }

  Positioned _buildFavoriteFlag() {
    return Positioned(
      top: 10,
      right: 10,
      child: FavouriteIcon(product: product, size: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Image.network(
              product.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            ProductBasicInfo(product: product),
            const SizedBox(height: 20),
            ProductQuantity(
              product: product,
              onChanged: onQuantityChanged,
            ),
            const SizedBox(height: 8),
            Accordion(
              title: 'Descrição',
              content: CustomText(
                text: product.description,
                style: kTitleRegular.copyWith(
                  color: Colors.grey.shade700,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
        _buildStockFlag(),
        _buildFavoriteFlag(),
      ],
    );
  }
}
