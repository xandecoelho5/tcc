import 'package:e_markety_client/features/product/components/favourite_item.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class FavouriteList extends StatelessWidget {
  const FavouriteList({Key? key, required this.favourites}) : super(key: key);

  final List<Product> favourites;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: favourites.length,
      itemBuilder: (ctx, i) => FavouriteItem(favourite: favourites[i]),
      separatorBuilder: (ctx, i) => const SizedBox(height: 12),
    );
  }
}
