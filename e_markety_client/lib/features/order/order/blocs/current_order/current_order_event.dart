part of 'current_order_bloc.dart';

abstract class CurrentOrderEvent {}

class GetCurrentOrder implements CurrentOrderEvent {
  final Function()? onCompleted;

  GetCurrentOrder({this.onCompleted});
}

class StreamCurrentOrder implements CurrentOrderEvent {}

class CloseStreamCurrentOrder implements CurrentOrderEvent {}

class UpdateOrderItems implements CurrentOrderEvent {
  final List<CartItem> items;

  UpdateOrderItems(this.items);
}
