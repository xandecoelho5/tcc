part of 'stock_bloc.dart';

abstract class StockState {}

class StockInitial implements StockState {}

class StockLoading implements StockState {}

class StockSuccess implements StockState {
  final CartItem cartItem;

  StockSuccess(this.cartItem);
}

class StockError implements StockState {
  final String message;

  StockError(this.message);
}
