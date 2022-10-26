part of 'cart_item_overview_bloc.dart';

enum CartItemOverviewStatus { initial, loading, success, failure }

class CartItemOverviewState extends Equatable {
  const CartItemOverviewState({
    this.status = CartItemOverviewStatus.initial,
    this.cartItems = const [],
  });

  final CartItemOverviewStatus status;
  final List<CartItem> cartItems;

  CartItemOverviewState copyWith({
    CartItemOverviewStatus? status,
    List<CartItem>? cartItems,
  }) {
    return CartItemOverviewState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => [status, cartItems];
}
