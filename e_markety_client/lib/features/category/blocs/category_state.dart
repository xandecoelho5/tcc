part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitial implements CategoryState {}

class CategoryLoading implements CategoryState {}

class CategorySuccess implements CategoryState {
  final List<Category> categories;

  CategorySuccess(this.categories);
}

class CategoryFailure implements CategoryState {
  final String message;

  CategoryFailure(this.message);
}
