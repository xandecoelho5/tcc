part of 'category_bloc.dart';

abstract class CategoryEvent {}

class CategoryGetAllEvent implements CategoryEvent {
  final int? size;

  CategoryGetAllEvent([this.size]);
}
