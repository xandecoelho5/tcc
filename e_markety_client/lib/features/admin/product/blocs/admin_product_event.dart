part of 'admin_product_bloc.dart';

abstract class AdminProductEvent {}

class ProductGetByIdEvent implements AdminProductEvent {
  final int id;

  ProductGetByIdEvent(this.id);
}

class ProductAddEvent implements AdminProductEvent {
  final Product product;

  ProductAddEvent(this.product);
}

class ProductEditEvent implements AdminProductEvent {
  final Product product;

  ProductEditEvent(this.product);
}
