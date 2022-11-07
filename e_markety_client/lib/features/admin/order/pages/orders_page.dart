import 'package:e_markety_client/features/admin/order/components/order_data_source.dart';
import 'package:e_markety_client/features/admin/order/components/order_notifier.dart';
import 'package:e_markety_client/features/admin/shared/data_responses/order_page_response.dart';
import 'package:e_markety_client/shared/utils/data_table_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/widgets/custom_data_table/custom_paginated_table.dart';
import '../../shared/data_responses/provider_settings.dart';
import '../../shared/widgets/empty_container.dart';

final sortColumns = [
  'id',
  'nome',
  'email',
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
  void initState() {
    super.initState();
    _provider.streamData();
  }

  @override
  void didChangeDependencies() {
    _provider.fetchData();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _provider.closeStream();
  }

  void sort(int columnIndex, bool ascending) {
    DataTableUtils.sort(_provider, sortColumns, columnIndex, ascending);
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(label: const Text('Código'), numeric: true, onSort: sort),
      const DataColumn(label: Text('Cliente')),
      const DataColumn(label: Text('Email')),
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
          return const EmptyContainer();
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
