import 'package:e_markety_client/features/order/shopping_cart/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/theme/constants.dart';
import '../../../../shared/widgets/filled_button.dart';
import '../../order/blocs/current_order/current_order_bloc.dart';
import '../../order/components/total_container.dart';
import '../../order/models/order.dart';
import 'cart_item_list.dart';

class LoadedCart extends StatelessWidget {
  const LoadedCart({Key? key, required this.cartItems}) : super(key: key);

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: CartItemList(cartItems: cartItems),
        ),
        BlocBuilder<CurrentOrderBloc, CurrentOrderState>(
          bloc: Modular.get<CurrentOrderBloc>(),
          builder: (context, state) {
            if (state is CurrentOrderError) {
              return Center(child: Text(state.message));
            }
            if (state is CurrentOrderLoaded) {
              return _BottomContainer(order: state.order);
            }

            return Container();
          },
        ),
      ],
    );
  }
}

class _BottomContainer extends StatelessWidget {
  const _BottomContainer({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TotalContainer(order: order),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: FilledButton(
                color: kSecondaryColor,
                onPressed: () =>
                    Modular.to.pushNamed('/order/checkout', arguments: order),
                text: 'Checkout',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
