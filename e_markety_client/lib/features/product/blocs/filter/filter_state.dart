part of 'filter_bloc.dart';

abstract class FilterState {}

class FilterInitial implements FilterState {}

class FilterLoading implements FilterState {}

class FilterLoaded implements FilterState {
  const FilterLoaded(this.query, this.products);

  final String query;
  final List<Product> products;
}

class FilterError implements FilterState {
  const FilterError(this.message);

  final String message;
}
