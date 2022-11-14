import 'package:e_markety_client/features/admin/home/models/status_summary.dart';
import 'package:e_markety_client/features/admin/home/services/report_service.dart';
import 'package:flutter/cupertino.dart';

class StatusSummaryNotifier extends ValueNotifier<List<StatusSummary>> {
  final IReportService _service;

  StatusSummaryNotifier(this._service) : super([]) {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await _service.getStatusSummary();
      response.fold(
        (l) => throw l,
        (r) => value = r,
      );
    } catch (e) {
      print(e);
    }
  }
}
