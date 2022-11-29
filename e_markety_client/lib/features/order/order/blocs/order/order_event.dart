part of 'order_bloc.dart';

abstract class OrderEvent {}

class OrderGetAllEvent implements OrderEvent {}

class OrderStreamEvent implements OrderEvent {}

class OrderCloseStreamEvent implements OrderEvent {}

class OrderPlaceEvent implements OrderEvent {
  final Order order;

  OrderPlaceEvent(this.order);
}
