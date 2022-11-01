part of 'admin_product_bloc.dart';

abstract class AdminProductState {}

class AdminProductInitial implements AdminProductState {}

class AdminProductLoading implements AdminProductState {}

class AdminProductSuccess implements AdminProductState {}

class AdminProductDeleteSuccess implements AdminProductState {}

class AdminProductLoaded implements AdminProductState {
  final Product product;

  AdminProductLoaded(this.product);
}

class AdminProductError implements AdminProductState {
  final String message;

  AdminProductError(this.message);
}
