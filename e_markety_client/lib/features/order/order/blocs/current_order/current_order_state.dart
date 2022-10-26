part of 'current_order_bloc.dart';

abstract class CurrentOrderState {}

class CurrentOrderInitial implements CurrentOrderState {}

class CurrentOrderLoading implements CurrentOrderState {}

class CurrentOrderLoaded implements CurrentOrderState {
  final Order order;

  CurrentOrderLoaded(this.order);
}

class CurrentOrderError implements CurrentOrderState {
  final String message;

  CurrentOrderError(this.message);
}
