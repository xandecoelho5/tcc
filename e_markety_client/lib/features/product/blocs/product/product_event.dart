part of 'product_bloc.dart';

abstract class ProductEvent {}

class ProductGetAllEvent implements ProductEvent {
  final int? size;

  ProductGetAllEvent([this.size]);
}

class ProductGetPageEvent implements ProductEvent {
  final int page;
  final int size;
  final String order;
  final bool asc;

  ProductGetPageEvent({
    required this.page,
    required this.size,
    required this.order,
    required this.asc,
  });
}
