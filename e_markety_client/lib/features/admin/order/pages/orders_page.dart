import 'package:e_markety_client/features/admin/order/components/order_data_source.dart';
import 'package:e_markety_client/features/admin/order/components/order_notifier.dart';
import 'package:e_markety_client/features/admin/shared/data_responses/order_page_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/widgets/custom_data_table/custom_paginated_table.dart';
import '../../shared/data_responses/provider_settings.dart';

final sortColumns = [
  'id',
  'usuarioId',
  'usuarioEmail',
  'total',
  'status',
  'data',
  'Ações',
];

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final _provider = Modular.get<OrderNotifier>();

  @override
  void didChangeDependencies() {
    _provider.fetchData();
    super.didChangeDependencies();
  }

  void sort(int columnIndex, bool ascending) {
    final columnName = sortColumns[columnIndex];
    _provider
      ..sortAscending = ascending
      ..sortColumnIndex = columnIndex
      ..sortColumnName = columnName
      ..fetchData();
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(label: const Text('Código'), numeric: true, onSort: sort),
      DataColumn(label: const Text('Cliente'), onSort: sort),
      DataColumn(label: const Text('Email'), onSort: sort),
      DataColumn(label: const Text('Preço'), numeric: true, onSort: sort),
      DataColumn(label: const Text('Status'), onSort: sort),
      DataColumn(label: const Text('Data'), onSort: sort),
      const DataColumn(label: Text('Ações')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProviderSettings>(
      valueListenable: _provider,
      builder: (context, value, child) {
        final _dataSource =
            OrderDataSource(value.pageResponse as OrderPageResponse);

        if (value.pageResponse.content.isEmpty) {
          return const SizedBox.shrink();
        }

        return CustomPaginatedTable(
          dataColumns: _buildDataColumns(),
          header: const Text('Pedidos'),
          onRowChanged: (index) => _provider.rowsPerPage = index!,
          onPageChanged: (index) =>
              _provider.currentPage = index ~/ _provider.rowsPerPage,
          rowsPerPage: _provider.rowsPerPage,
          showActions: true,
          source: _dataSource,
          sortColumnIndex: _provider.sortColumnIndex,
          sortColumnAsc: _provider.sortAscending,
        );
      },
    );
  }
}
