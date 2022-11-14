part of 'stock_bloc.dart';

abstract class StockEvent {}

class VerifyStock implements StockEvent {
  final CartItem cartItem;

  VerifyStock(this.cartItem);
}
