part of 'order_bloc.dart';

abstract class OrderEvent {}

class OrderGetAllEvent implements OrderEvent {}

class OrderPlaceEvent implements OrderEvent {
  final Order order;

  OrderPlaceEvent(this.order);
}
