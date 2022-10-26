import 'package:e_markety_client/features/order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';
import 'package:e_markety_client/features/product/components/category_chip.dart';
import 'package:e_markety_client/features/product/components/favourite_icon.dart';
import 'package:e_markety_client/features/product/components/product_flag_widget.dart';
import 'package:e_markety_client/shared/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/flag_type.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

  void _onAddItemToCart() {
    Modular.get<CartItemOverviewBloc>().add(
      CartItemOverviewCartItemAdd(CartItem.empty(product: product)),
    );
  }

  Positioned _buildPromotionOrNewFlag() {
    return Positioned(
      top: 10,
      left: 0,
      child: ProductFlagWidget.small(
        flagType:
            product.hasPromotion ? FlagType.promotion : FlagType.newProduct,
        promotionPercentage: product.discountPercent,
      ),
    );
  }

  Positioned _buildFavoriteFlag() {
    return Positioned(
      top: 6,
      right: 5,
      child: FavouriteIcon(product: product),
    );
  }

  Positioned _buildCartButton() {
    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        heroTag: product.name,
        backgroundColor: kPrimaryColor,
        mini: true,
        elevation: 10,
        onPressed: _onAddItemToCart,
        child: const Icon(
          Icons.add_shopping_cart,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }

  Column _productInfo() {
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
              '\$${product.finalPrice.toStringAsFixed(2)}',
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
    return InkWell(
      onTap: () => Modular.to.pushNamed('/product-details', arguments: product),
      child: Card(
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
      ),
    );
  }
}
