import 'package:e_markety_client/features/admin/home/models/monthly_orders.dart';
import 'package:flutter/material.dart';

import '../services/report_service.dart';

class MonthlyOrdersNotifier extends ValueNotifier<List<MonthlyOrders>> {
  final IReportService _service;

  MonthlyOrdersNotifier(this._service) : super([]) {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await _service.getMonthlyOrders();
      response.fold(
        (l) => throw l,
        (r) => value = r,
      );
    } catch (e) {
      print(e);
    }
  }
}
