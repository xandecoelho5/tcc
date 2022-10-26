import 'package:e_markety_client/features/product/components/product_basic_info.dart';
import 'package:e_markety_client/features/product/components/product_flag_widget.dart';
import 'package:e_markety_client/features/product/components/product_quantity.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';
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

  Text _productDescription() {
    return Text(
      product.description,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.5,
      ),
      maxLines: 5,
      overflow: TextOverflow.ellipsis, // TODO implementar botão de ver mais
    );
  }

  Positioned _buildStockFlag() {
    return const Positioned(
      top: 20,
      left: 3,
      child: ProductFlagWidget.big(flagType: FlagType.inStock),
    );
  }

  Positioned _buildFavoriteFlag() {
    return Positioned(
      top: 16,
      right: 16,
      child: FavouriteIcon(product: product, size: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          color: kScaffoldColor, // TODO GRADIENT de branco pra cinza
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill,
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
                content: _productDescription(),
              ),
            ],
          ),
        ),
        _buildStockFlag(),
        _buildFavoriteFlag(),
      ],
    );
  }
}
