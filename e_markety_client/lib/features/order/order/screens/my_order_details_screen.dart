import 'package:e_markety_client/shared/extensions/double_extension.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../shared/theme/constants.dart';
import '../../shopping_cart/models/cart_item.dart';

class MyOrderDetailsScreen extends StatelessWidget {
  const MyOrderDetailsScreen({Key? key, required this.items}) : super(key: key);

  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(
        title: 'Detalhes do pedido',
        showAction: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (ctx, i) => _OrderItem(item: items[i]),
        separatorBuilder: (ctx, i) => const SizedBox(height: 10),
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({Key? key, required this.item}) : super(key: key);

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: kElevationToShadow[1],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Image.network(
                item.product.imageUrl,
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
                        '${item.unitPrice.toReal} x ${item.quantityText}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.product.formattedWeight,
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
      ),
    );
  }
}
