import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/widgets/slidable_card.dart';
import 'package:flutter/material.dart';

import '../../../shared/theme/constants.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({Key? key, required this.favourite}) : super(key: key);

  final Product favourite;

  @override
  Widget build(BuildContext context) {
    return SlidableCard(
      valueKey: favourite.id,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Image.network(
              favourite.imageUrl,
              width: 110,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${favourite.finalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kSecondaryColor,
                    ),
                  ),
                  Text(
                    favourite.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    favourite.formattedWeight,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Material(
              color: kPrimaryColor,
              shape: const CircleBorder(),
              elevation: 10,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(100),
                child: const Padding(
                  padding: EdgeInsets.all(11),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
