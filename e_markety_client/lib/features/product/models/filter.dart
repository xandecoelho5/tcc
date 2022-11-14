import 'package:e_markety_client/features/category/models/category.dart';
import 'package:e_markety_client/features/product/models/sort_type.dart';
import 'package:flutter/material.dart';

class Filter {
  final String name;
  final RangeValues? values;
  final SortType sortType;
  Category? category;

  Filter({
    this.name = '',
    this.values,
    this.sortType = SortType.bestSellers,
    this.category,
  });

  Filter copyWith({
    String? name,
    RangeValues? values,
    SortType? sortType,
    Category? category,
  }) {
    return Filter(
      name: name ?? this.name,
      values: values ?? this.values,
      sortType: sortType ?? this.sortType,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': name.isNotEmpty ? name : null,
      'precoMin': values?.start,
      'precoMax': values?.end,
      'tipoOrdenacao': sortType.toRemoteName(),
      'categoriaId': category?.id,
    };
  }

  @override
  String toString() {
    return 'Filter{name: $name, values: $values, sortType: $sortType, category: $category}';
  }
}
