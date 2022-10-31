import 'package:e_markety_client/features/category/models/category.dart';
import 'package:flutter/cupertino.dart';

import '../../../../category/services/category_service.dart';

class CategoryNotifier extends ValueNotifier<List<Category>> {
  final ICategoryService _service;

  CategoryNotifier(this._service) : super([]) {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await _service.getCategories(0);
      response.fold(
        (l) => throw l,
        (r) => value = r,
      );
    } catch (e) {
      print(e);
    }
  }
}
