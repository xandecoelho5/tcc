import 'package:e_markety_client/features/admin/product/components/notifiers/product_notifier.dart';
import 'package:e_markety_client/features/admin/product/datasources/product_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/widgets/custom_data_table/custom_paginated_table.dart';

final sortColumns = [
  'produto',
  'nome',
  'preco',
  'percentualDesconto',
  'quantidadeVendida',
  'estoque',
  'Ações',
];

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  void sort(int columnIndex, bool ascending, ProductNotifier provider) {
    final columnName = sortColumns[columnIndex];
    provider
      ..sortAscending = ascending
      ..sortColumnIndex = columnIndex
      ..sortColumnName = columnName
      ..fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<ProductNotifier>();
    final _pageResponse = _provider.pageResponse;
    final _dataSource = ProductDataSource(_pageResponse);

    if (_pageResponse.content.isEmpty) {
      return const SizedBox.shrink();
    }

    return CustomPaginatedTable(
      actions: <IconButton>[
        IconButton(
          splashColor: Colors.transparent,
          icon: const Icon(Icons.refresh),
          onPressed: () {
            _provider.fetchData();
            _showSBar(context, 'Atualizando');
          },
        ),
      ],
      dataColumns: [
        const DataColumn(label: Text('Produto')),
        DataColumn(
          label: const Text('Nome'),
          onSort: (columnIndex, asc) => sort(columnIndex, asc, _provider),
        ),
        DataColumn(
          label: const Text('Preço'),
          numeric: true,
          onSort: (columnIndex, asc) => sort(columnIndex, asc, _provider),
        ),
        DataColumn(
          label: const Text('Promoção'),
          numeric: true,
          onSort: (columnIndex, asc) => sort(columnIndex, asc, _provider),
        ),
        DataColumn(
          label: const Text('Vendidos'),
          numeric: true,
          onSort: (columnIndex, asc) => sort(columnIndex, asc, _provider),
        ),
        DataColumn(
          label: const Text('Estoque'),
          numeric: true,
          onSort: (columnIndex, asc) => sort(columnIndex, asc, _provider),
        ),
        const DataColumn(label: Text('Ações')),
      ],
      header: const Text('Produtos'),
      onRowChanged: (index) => _provider.rowsPerPage = index!,
      onPageChanged: (index) =>
          _provider.currentPage = index ~/ _provider.rowsPerPage,
      rowsPerPage: _provider.rowsPerPage,
      showActions: true,
      source: _dataSource,
      sortColumnIndex: _provider.sortColumnIndex,
      sortColumnAsc: _provider.sortAscending,
    );
  }

  void _showSBar(BuildContext c, String textToShow) {
    ScaffoldMessenger.of(c).showSnackBar(
      SnackBar(
        content: Text(textToShow),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }
}
