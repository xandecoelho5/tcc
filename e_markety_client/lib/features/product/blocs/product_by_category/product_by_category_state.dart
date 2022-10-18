part of 'product_by_category_bloc.dart';

abstract class ProductByCategoryState {}

class ProductByCategoryInitial extends ProductByCategoryState {}

class ProductByCategoryLoading extends ProductByCategoryState {}

class ProductByCategoryLoaded extends ProductByCategoryState {
  final List<Product> products;

  ProductByCategoryLoaded(this.products);
}

class ProductByCategoryError extends ProductByCategoryState {
  final String message;

  ProductByCategoryError(this.message);
}
