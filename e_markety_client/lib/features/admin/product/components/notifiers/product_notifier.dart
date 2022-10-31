import 'package:e_markety_client/features/product/services/product_service.dart';
import 'package:e_markety_client/shared/data_responses/product_page_response.dart';
import 'package:flutter/material.dart';

import '../../../../product/models/product.dart';

class ProductNotifier with ChangeNotifier {
  final IProductService _service;

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  String _sortColumnName = 'nome';
  int _sortColumnIndex = 1;
  bool _sortAscending = true;
  int _currentPage = 0;

  ProductNotifier(this._service) {
    fetchData();
  }

  ProductPageResponse _pageResponse = const ProductPageResponse.empty();

  ProductPageResponse get pageResponse => _pageResponse;

  List<Product> get products => _pageResponse.content;

  void add(Product product) {
    _pageResponse.content.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _pageResponse.content.remove(product);
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
    notifyListeners();
  }
}
