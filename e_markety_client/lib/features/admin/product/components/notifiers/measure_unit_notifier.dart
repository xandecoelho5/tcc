import 'package:e_markety_client/features/admin/product/services/measure_unit_service.dart';
import 'package:e_markety_client/features/product/models/measure_unit.dart';
import 'package:flutter/cupertino.dart';

class MeasureUnitNotifier extends ValueNotifier<List<MeasureUnit>> {
  MeasureUnitNotifier(this._service) : super([]) {
    fetchData();
  }

  final IMeasureUnitService _service;

  Future<void> fetchData() async {
    try {
      final response = await _service.getMeasureUnits();
      response.fold(
        (l) => throw l,
        (r) => value = r,
      );
    } catch (e) {
      print(e);
    }
  }
}
