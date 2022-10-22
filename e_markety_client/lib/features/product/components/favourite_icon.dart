import 'package:e_markety_client/features/product/blocs/favourite/favourite_bloc.dart';
import 'package:e_markety_client/features/product/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/theme/constants.dart';
import '../../user/auth/blocs/auth_bloc.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    Key? key,
    required this.product,
    this.size,
  }) : super(key: key);

  final Product product;
  final double? size;

  InkWell _icon(bool isFavorite) {
    return InkWell(
      onTap: () {
        if (!isFavorite) {
          Modular.get<FavouriteBloc>().add(FavouriteAdd(product));
        } else {
          Modular.get<FavouriteBloc>().add(FavouriteRemove(product.id));
        }
      },
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? kSecondaryColor : Colors.grey.shade300,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: Modular.get<AuthBloc>(),
      builder: (context, state) {
        if (state is AuthLogged) {
          return _icon(state.user.isFavourite(product.id));
        }
        return Icon(
          Icons.favorite_border,
          color: Colors.grey.shade300,
          size: size,
        );
      },
    );
  }
}
