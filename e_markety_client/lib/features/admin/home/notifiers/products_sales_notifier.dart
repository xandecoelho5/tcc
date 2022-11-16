import 'package:e_markety_client/features/admin/home/models/products_sales.dart';
import 'package:flutter/material.dart';

import '../services/report_service.dart';

class ProductsSalesNotifier extends ValueNotifier<List<ProductsSales>> {
  final IReportService _service;

  ProductsSalesNotifier(this._service) : super([]);

  Future<void> fetchData(String sort) async {
    try {
      final response = await _service.getProductsSales(sort);
      response.fold(
        (l) => throw l,
        (r) => value = r,
      );
    } catch (e) {
      print(e);
    }
  }
}
