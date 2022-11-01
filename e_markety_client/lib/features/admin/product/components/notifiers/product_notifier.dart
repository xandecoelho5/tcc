import 'package:e_markety_client/features/admin/shared/data_responses/page_response.dart';
import 'package:e_markety_client/features/admin/shared/data_responses/provider_settings.dart';
import 'package:flutter/material.dart';

import '../../../../product/services/product_service.dart';
import '../../../shared/data_responses/product_page_response.dart';

class ProductNotifier extends ValueNotifier<ProviderSettings> {
  final IProductService _service;

  ProductNotifier(this._service)
      : super(
          ProviderSettings(
            rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
            sortColumnName: 'nome',
            pageResponse: ProductPageResponse.empty(),
          ),
        );

  PageResponse get pageResponse => value.pageResponse;

  bool get hasData => pageResponse.content.isNotEmpty;

  String get sortColumnName => value.sortColumnName;

  set sortColumnName(String name) =>
      value = value.copyWith(sortColumnName: name);

  int get sortColumnIndex => value.sortColumnIndex;

  set sortColumnIndex(int index) =>
      value = value.copyWith(sortColumnIndex: index);

  bool get sortAscending => value.sortAscending;

  set sortAscending(bool asc) => value = value.copyWith(sortAscending: asc);

  int get rowsPerPage => value.rowsPerPage;

  set rowsPerPage(int rows) => value = value.copyWith(rowsPerPage: rows);

  int get currentPage => value.currentPage;

  set currentPage(int page) {
    value = value.copyWith(currentPage: page);
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await _service.getProductsPaginated(
      page: currentPage,
      size: rowsPerPage,
      order: sortColumnName,
      asc: sortAscending,
    );
    response.fold(
      (l) => print(l.message),
      (r) => value = value.copyWith(pageResponse: r),
    );
  }
}
