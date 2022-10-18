part of 'product_bloc.dart';

abstract class ProductEvent {}

class ProductGetAllEvent implements ProductEvent {
  final int? size;

  ProductGetAllEvent([this.size]);
}
