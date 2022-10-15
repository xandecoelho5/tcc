part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitial implements CategoryState {}

class CategoryLoading implements CategoryState {}

class CategoryLoaded implements CategoryState {
  final List<Category> categories;

  CategoryLoaded(this.categories);
}

class CategoryError implements CategoryState {
  final String message;

  CategoryError(this.message);
}
