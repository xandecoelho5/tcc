part of 'order_bloc.dart';

abstract class OrderState {}

class OrderInitial implements OrderState {}

class OrderLoading implements OrderState {}

class OrderLoaded implements OrderState {
  final List<Order> orders;

  OrderLoaded(this.orders);
}

class OrderError implements OrderState {
  final String message;

  OrderError(this.message);
}
