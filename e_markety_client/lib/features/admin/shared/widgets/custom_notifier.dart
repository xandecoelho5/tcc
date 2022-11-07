import 'package:flutter/cupertino.dart';

import '../data_responses/page_response.dart';
import '../data_responses/provider_settings.dart';
import '../services/paginated_service.dart';

class CustomNotifier extends ValueNotifier<ProviderSettings> {
  final IPaginatedService _service;

  CustomNotifier(IPaginatedService service, ProviderSettings providerSettings)
      : _service = service,
        super(providerSettings);

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
    final response = await _service.getPaginated(
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
