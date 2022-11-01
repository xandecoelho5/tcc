part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}

class ProductPageLoaded extends ProductState {
  final ProductPageResponse pageResponse;

  ProductPageLoaded(this.pageResponse);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
