part of 'product_price_bloc.dart';

abstract class ProductPriceState {}

class ProductPriceInitial extends ProductPriceState {}

class ProductPriceLoaded extends ProductPriceState {
  final PriceRange priceRange;

  ProductPriceLoaded(this.priceRange);
}

class ProductPriceError extends ProductPriceState {
  final String message;

  ProductPriceError(this.message);
}
