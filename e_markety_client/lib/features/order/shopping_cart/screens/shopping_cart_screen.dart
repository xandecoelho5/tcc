import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
import 'package:e_markety_client/features/order/shopping_cart/components/empty_cart.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../components/loaded_cart.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context, title: 'Carrinho'),
      body: BlocListener<CartItemOverviewBloc, CartItemOverviewState>(
        bloc: Modular.get<CartItemOverviewBloc>()
          ..add(const CartItemOverviewSubscriptionRequested()),
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == CartItemOverviewStatus.failure) {
            Modular.get<ISnackBarService>().showError(context, 'Deu Merda');
          }
        },
        child: BlocBuilder<CartItemOverviewBloc, CartItemOverviewState>(
          bloc: Modular.get<CartItemOverviewBloc>(),
          builder: (context, state) {
            if (state.cartItems.isEmpty) {
              if (state.status == CartItemOverviewStatus.loading) {
                return const Center(child: RefreshProgressIndicator());
              }
              if (state.status == CartItemOverviewStatus.success) {
                return const EmptyCart();
              }
              return const SizedBox();
            }
            return LoadedCart(cartItems: state.cartItems);
          },
        ),
      ),
    );
  }
}
