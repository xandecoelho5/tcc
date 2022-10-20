part of 'cart_item_overview_bloc.dart';

abstract class CartItemOverviewEvent extends Equatable {
  const CartItemOverviewEvent();

  @override
  List<Object> get props => [];
}

class CartItemOverviewSubscriptionRequested extends CartItemOverviewEvent {
  const CartItemOverviewSubscriptionRequested();
}

class CartItemOverviewCartItemAdd extends CartItemOverviewEvent {
  const CartItemOverviewCartItemAdd(this.cartItem);

  final CartItem cartItem;

  @override
  List<Object> get props => [cartItem];
}

class CartItemOverviewCartItemDeleted extends CartItemOverviewEvent {
  const CartItemOverviewCartItemDeleted(this.cartItem);

  final CartItem cartItem;

  @override
  List<Object> get props => [cartItem];
}
