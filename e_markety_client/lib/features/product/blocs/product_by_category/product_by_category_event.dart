part of 'product_by_category_bloc.dart';

abstract class ProductByCategoryEvent {}

class ProductGetAllByCategoryEvent implements ProductByCategoryEvent {
  final int categoryId;

  ProductGetAllByCategoryEvent(this.categoryId);
}
