import 'package:e_markety_client/features/product/components/product_slidable_item.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:e_markety_client/shared/utils/modular_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/theme/constants.dart';
import '../../order/shopping_cart/models/cart_item.dart';
import '../blocs/favourite/favourite_bloc.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({Key? key, required this.favourite}) : super(key: key);

  final Product favourite;

  void _onRemoveFromFavourites() {
    Modular.get<FavouriteBloc>().add(FavouriteRemove(favourite.id!));
  }

  @override
  Widget build(BuildContext context) {
    return ProductSlidableItem(
      product: favourite,
      onConfirmDelete: _onRemoveFromFavourites,
      rightWidget: Material(
        color: kPrimaryColor,
        shape: const CircleBorder(),
        elevation: 10,
        child: InkWell(
          onTap: () =>
              ModularUtils.addToCart(CartItem.empty(product: favourite)),
          customBorder: const CircleBorder(),
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
