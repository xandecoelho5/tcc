import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/product/models/sort_type.dart';
import 'package:flutter/material.dart';

class Filter {
  final RangeValues values;
  final SortType sortType;
  final Category category;

  const Filter({
    required this.values,
    required this.sortType,
    required this.category,
  });

  Filter copyWith({
    RangeValues? values,
    SortType? sortType,
    Category? category,
  }) {
    return Filter(
      values: values ?? this.values,
      sortType: sortType ?? this.sortType,
      category: category ?? this.category,
    );
  }
}
