import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/admin/product/blocs/admin_product_bloc.dart';
import 'package:e_markety_client/features/admin/product/components/notifiers/product_notifier.dart';
import 'package:e_markety_client/features/admin/product/datasources/product_data_source.dart';
import 'package:e_markety_client/features/admin/shared/data_responses/provider_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/widgets/custom_data_table/custom_paginated_table.dart';
import '../../shared/data_responses/product_page_response.dart';

final sortColumns = [
  'produto',
  'nome',
  'preco',
  'percentualDesconto',
  'quantidadeVendida',
  'estoque',
  'Ações',
];

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _provider = Modular.get<ProductNotifier>();

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
      const DataColumn(label: Text('Produto')),
      DataColumn(label: const Text('Nome'), onSort: sort),
      DataColumn(label: const Text('Preço'), numeric: true, onSort: sort),
      DataColumn(label: const Text('Promoção'), numeric: true, onSort: sort),
      DataColumn(label: const Text('Vendidos'), numeric: true, onSort: sort),
      DataColumn(label: const Text('Estoque'), numeric: true, onSort: sort),
      const DataColumn(label: Text('Ações')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminProductBloc, AdminProductState>(
      bloc: Modular.get<AdminProductBloc>(),
      listener: (context, state) {
        if (state is AdminProductDeleteSuccess) {
          _provider.fetchData();
          Modular.get<ISnackBarService>()
              .showSuccess(context, 'Produto excluído com sucesso');
        }
        if (state is AdminProductError) {
          Modular.get<ISnackBarService>().showError(
            context,
            'Erro ao excluir produto: ${state.message}',
          );
        }
      },
      child: ValueListenableBuilder<ProviderSettings>(
        valueListenable: _provider,
        builder: (context, value, child) {
          final _dataSource =
              ProductDataSource(value.pageResponse as ProductPageResponse);

          if (value.pageResponse.content.isEmpty) {
            return const SizedBox.shrink();
          }

          return CustomPaginatedTable(
            dataColumns: _buildDataColumns(),
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
        },
      ),
    );
  }
}
