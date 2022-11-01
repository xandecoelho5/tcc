import 'package:flutter/material.dart';

import '../../../../../shared/data_responses/product_page_response.dart';
import '../../../../product/services/product_service.dart';

class ProductNotifier with ChangeNotifier {
  final IProductService _service;

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String _sortColumnName = 'nome';
  int _sortColumnIndex = 1;
  bool _sortAscending = true;
  int _currentPage = 0;
  bool _isLoading = false;

  ProductNotifier(this._service) {
    fetchData();
  }

  ProductPageResponse _pageResponse = const ProductPageResponse.empty();

  ProductPageResponse get pageResponse => _pageResponse;

  bool get isLoading => _isLoading;

  set pageResponse(ProductPageResponse pageResponse) {
    _pageResponse = pageResponse;
    notifyListeners();
  }

  String get sortColumnName => _sortColumnName;

  set sortColumnName(String sortColumnName) {
    _sortColumnName = sortColumnName;
    notifyListeners();
  }

  int get sortColumnIndex => _sortColumnIndex;

  set sortColumnIndex(int sortColumnIndex) {
    _sortColumnIndex = sortColumnIndex;
    notifyListeners();
  }

  bool get sortAscending => _sortAscending;

  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }

  int get rowsPerPage => _rowsPerPage;

  set rowsPerPage(int rowsPerPage) {
    _rowsPerPage = rowsPerPage;
    notifyListeners();
  }

  int get currentPage => _currentPage;

  set currentPage(int currentPage) {
    _currentPage = currentPage;
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    final response = await _service.getProductsPaginated(
      page: _currentPage,
      size: _rowsPerPage,
      order: _sortColumnName,
      asc: _sortAscending,
    );
    response.fold(
      (l) => print(l.message),
      (r) => _pageResponse = r,
    );
    _isLoading = false;
    notifyListeners();
  }
}
