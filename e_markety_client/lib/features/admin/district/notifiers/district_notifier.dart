import 'package:e_markety_client/features/order/address/models/district.dart';
import 'package:e_markety_client/features/order/address/services/district_service.dart';
import 'package:flutter/material.dart';

class DistrictNotifier extends ValueNotifier<List<District>> {
  DistrictNotifier(this._service) : super([]);

  final IDistrictService _service;

  Future<void> fetchData() async {
    try {
      final response = await _service.getDistrictsWithoutCurrentCompany();
      response.fold(
        (l) => throw l,
        (r) => value = r,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAllData() async {
    try {
      final response = await _service.getDistricts();
      response.fold(
        (l) => throw l,
        (r) => value = r,
      );
    } catch (e) {
      print(e);
    }
  }
}
