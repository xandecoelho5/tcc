import 'package:e_markety_client/features/order/order/blocs/current_order/current_order_bloc.dart';
import 'package:e_markety_client/features/order/shopping_cart/repositories/cart_item_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../models/cart_item.dart';

part 'cart_item_overview_event.dart';
part 'cart_item_overview_state.dart';

class CartItemOverviewBloc
    extends Bloc<CartItemOverviewEvent, CartItemOverviewState> {
  final CartItemRepository _repository;

  CartItemOverviewBloc(this._repository)
      : super(const CartItemOverviewState()) {
    on<CartItemOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<CartItemOverviewCartItemDeleted>(_onCartItemDeleted);
    on<CartItemOverviewCartItemAdd>(_onCartItemAdd);
    on<CartItemQuantityIncrement>(_onQuantityIncrement);
    on<CartItemQuantityDecrement>(_onQuantityDecrement);
  }

  Future<void> _onSubscriptionRequested(event, Emitter emit) async {
    emit(state.copyWith(status: CartItemOverviewStatus.loading));

    await emit.forEach<List<CartItem>>(
      _repository.getCartItems(),
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
    _repository.removeFromCart(event.cartItem.product.id!);
  }

  void _onCartItemAdd(CartItemOverviewCartItemAdd event, emit) {
    _repository.addToCart(event.cartItem);
  }

  void _onQuantityIncrement(CartItemQuantityIncrement event, emit) {
    _repository.quantityIncrement(event.cartItem);
  }

  void _onQuantityDecrement(CartItemQuantityDecrement event, emit) {
    _repository.quantityDecrement(event.cartItem);
  }
}
