import 'package:e_markety_client/features/order/order/models/order_status.dart';
import 'package:e_markety_client/features/order/shopping_cart/blocs/overview/cart_item_overview_bloc.dart';
import 'package:e_markety_client/features/order/shopping_cart/components/empty_cart.dart';
import 'package:e_markety_client/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../order/blocs/current_order/current_order_bloc.dart';
import '../components/loaded_cart.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(title: 'Carrinho', showAction: false),
      body: BlocListener<CurrentOrderBloc, CurrentOrderState>(
        bloc: Modular.get<CurrentOrderBloc>()..add(GetCurrentOrder()),
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is CurrentOrderLoaded &&
              Modular.to.path == '/order/shopping-cart') {
            if (state.order.status != OrderStatus.pending) {
              Modular.to
                  .pushNamedAndRemoveUntil('/order/track-order', (_) => false);
            }
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
