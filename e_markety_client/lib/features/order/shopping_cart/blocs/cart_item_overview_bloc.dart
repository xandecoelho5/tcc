import 'package:e_markety_client/features/order/shopping_cart/repositories/cart_item_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/cart_item.dart';

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
  }

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: CartItemOverviewStatus.loading));

    await emit.forEach<List<CartItem>>(
      _repository.getCartItems(),
      onData: (cartItems) => state.copyWith(
        status: CartItemOverviewStatus.success,
        cartItems: cartItems,
      ),
      onError: (_, __) => state.copyWith(
        status: CartItemOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onCartItemDeleted(
    CartItemOverviewCartItemDeleted event,
    emit,
  ) async {
    _repository.removeFromCart(event.cartItem.id);
  }

  Future<void> _onCartItemAdd(CartItemOverviewCartItemAdd event, emit) async {
    _repository.addToCart(event.cartItem);
  }
}
