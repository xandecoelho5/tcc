import 'package:e_markety_client/features/order/order/blocs/current_order/current_order_bloc.dart';
import 'package:e_markety_client/features/order/shopping_cart/services/cart_item_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/cart_item.dart';

part 'cart_item_overview_event.dart';
part 'cart_item_overview_state.dart';

class CartItemOverviewBloc
    extends Bloc<CartItemOverviewEvent, CartItemOverviewState> {
  final ICartItemService _service;

  CartItemOverviewBloc(this._service) : super(const CartItemOverviewState()) {
    on<CartItemOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<CartItemOverviewCartItemDeleted>(_onCartItemDeleted);
    on<CartItemOverviewCartItemAdd>(_onCartItemAdd);
    on<CartItemQuantityIncrement>(_onQuantityIncrement);
    on<CartItemQuantityDecrement>(_onQuantityDecrement);
  }

  Future<void> _onSubscriptionRequested(event, Emitter emit) async {
    emit(state.copyWith(status: CartItemOverviewStatus.loading));
    await _service.init();

    await emit.forEach<List<CartItem>>(
      _service.getCartItems(),
      onData: (cartItems) {
        Modular.get<CurrentOrderBloc>().add(UpdateOrderItems(cartItems));
        return state.copyWith(
          status: CartItemOverviewStatus.success,
          cartItems: cartItems,
        );
      },
      onError: (_, __) => state.copyWith(
        status: CartItemOverviewStatus.failure,
      ),
    );
  }

  void _onCartItemDeleted(CartItemOverviewCartItemDeleted event, emit) {
    _service.removeFromCart(event.cartItem.product.id!);
  }

  void _onCartItemAdd(CartItemOverviewCartItemAdd event, emit) {
    _service.addToCart(event.cartItem);
  }

  void _onQuantityIncrement(CartItemQuantityIncrement event, emit) {
    _service.quantityIncrement(event.cartItem);
  }

  void _onQuantityDecrement(CartItemQuantityDecrement event, emit) {
    _service.quantityDecrement(event.cartItem);
  }
}
