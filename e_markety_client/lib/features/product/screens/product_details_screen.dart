import 'package:e_markety_client/features/product/components/accordion.dart';
import 'package:e_markety_client/features/product/components/category_chip.dart';
import 'package:e_markety_client/features/product/components/product_flag_widget.dart';
import 'package:e_markety_client/features/product/models/flag_type.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:e_markety_client/shared/widgets/quantity_button.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  Padding _basicInfo() {
    Row productValues() {
      return Row(
        children: [
          Text(
            '\$${product.finalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              color: kSecondaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          // if (product.hasPromotion)
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Color(0XFFCEB35C),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryChip.big(label: product.category.name),
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
          productValues(),
        ],
      ),
    );
  }

  Padding _quantityButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kBasicLightColor.withOpacity(1),
          // TODO - add gradient from white to kBasicLightColor
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: const [
                QuantityButton(icon: '-', height: double.infinity),
                SizedBox(
                  width: 55,
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                QuantityButton(
                  icon: '+',
                  height: double.infinity,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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

  Column _productInformation() {
    final divider = Divider(
      height: 14,
      color: Colors.grey.shade400,
      thickness: 1,
    );

    Row infoRow(key, value) {
      return Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              key,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        infoRow('Brand', 'Loose'),
        divider,
        infoRow('Manufacturer', 'Private Label'),
        divider,
        infoRow('Country of Origin', 'India'),
        divider,
        infoRow('Food Type', 'Organic'),
        // TODO verificar se precisa implementar isso
      ],
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
      child: Icon(
        product.isFavorite ? Icons.favorite : Icons.favorite_border,
        color: product.isFavorite ? kSecondaryColor : Colors.grey.shade300,
        size: 30,
      ),
    );
  }

  Stack _details() {
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
              _basicInfo(),
              const SizedBox(height: 20),
              _quantityButtons(),
              const SizedBox(height: 8),
              Accordion(
                title: 'Description',
                content: _productDescription(),
              ),
              Accordion(
                title: 'Product Information',
                content: _productInformation(),
              ),
            ],
          ),
        ),
        _buildStockFlag(),
        _buildFavoriteFlag(),
      ],
    );
  }

  Row _addToCartButton() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 100),
              backgroundColor: kSecondaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(''),
                  Text(
                    'Add to cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(Icons.shopping_bag_outlined),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        context,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 124, 16, 16),
                child: _details(),
              ),
            ),
          ),
          Expanded(child: _addToCartButton()),
        ],
      ),
    );
  }
}
