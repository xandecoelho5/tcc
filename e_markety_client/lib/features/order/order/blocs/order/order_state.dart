part of 'order_bloc.dart';

abstract class OrderState {}

class OrderInitial implements OrderState {}

class OrderLoading implements OrderState {}

class OrderSuccess implements OrderState {
  final Order order;

  OrderSuccess(this.order);
}

class OrderLoaded implements OrderState {
  final List<Order> orders;

  OrderLoaded(this.orders);
}

class OrderError implements OrderState {
  final String message;

  OrderError(this.message);
}
