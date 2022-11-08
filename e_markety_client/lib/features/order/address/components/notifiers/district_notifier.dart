import 'package:e_markety_client/features/company/services/company_district_service.dart';
import 'package:e_markety_client/features/order/address/models/district.dart';
import 'package:flutter/material.dart';

class DistrictNotifier extends ValueNotifier<List<District>> {
  DistrictNotifier(this._service) : super([]) {
    fetchData();
  }

  final ICompanyDistrictService _service;

  Future<void> fetchData() async {
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
