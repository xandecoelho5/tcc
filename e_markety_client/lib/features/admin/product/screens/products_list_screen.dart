import 'package:e_markety_client/core/services/snack_bar/snackbar_service.dart';
import 'package:e_markety_client/features/admin/product/blocs/admin_product_bloc.dart';
import 'package:e_markety_client/features/admin/product/components/notifiers/product_notifier.dart';
import 'package:e_markety_client/features/admin/product/datasources/product_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  List<IconButton> _buildActions(ProductNotifier provider) {
    return [
      IconButton(
        splashColor: Colors.transparent,
        icon: const Icon(Icons.refresh),
        onPressed: () {
          provider.fetchData();
          _showSBar(context, 'Atualizando');
        },
      ),
    ];
  }

  List<DataColumn> _buildDataColumns(ProductNotifier provider) {
    return [
      const DataColumn(label: Text('Produto')),
      DataColumn(
        label: const Text('Nome'),
        onSort: (columnIndex, asc) => sort(columnIndex, asc, provider),
      ),
      DataColumn(
        label: const Text('Preço'),
        numeric: true,
        onSort: (columnIndex, asc) => sort(columnIndex, asc, provider),
      ),
      DataColumn(
        label: const Text('Promoção'),
        numeric: true,
        onSort: (columnIndex, asc) => sort(columnIndex, asc, provider),
      ),
      DataColumn(
        label: const Text('Vendidos'),
        numeric: true,
        onSort: (columnIndex, asc) => sort(columnIndex, asc, provider),
      ),
      DataColumn(
        label: const Text('Estoque'),
        numeric: true,
        onSort: (columnIndex, asc) => sort(columnIndex, asc, provider),
      ),
      const DataColumn(label: Text('Ações')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _provider = ModularWatchExtension(context).watch<ProductNotifier>();
    final _pageResponse = _provider.pageResponse;
    final _dataSource = ProductDataSource(_pageResponse);

    if (_pageResponse.content.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocListener<AdminProductBloc, AdminProductState>(
      bloc: Modular.get<AdminProductBloc>(),
      listener: (context, state) {
        if (state is AdminProductDeleteSuccess) {
          _provider.fetchData();
          Modular.get<ISnackBarService>()
              .showSuccess(context, 'Produto excluído com sucesso');
        }
        if (state is AdminProductError) {
          Modular.get<ISnackBarService>().showSuccess(
            context,
            'Erro ao excluir produto: ${state.message}',
          );
        }
      },
      child: CustomPaginatedTable(
        actions: _buildActions(_provider),
        dataColumns: _buildDataColumns(_provider),
        header: const Text('Produtos'),
        onRowChanged: (index) => _provider.rowsPerPage = index!,
        onPageChanged: (index) =>
            _provider.currentPage = index ~/ _provider.rowsPerPage,
        rowsPerPage: _provider.rowsPerPage,
        showActions: true,
        source: _dataSource,
        sortColumnIndex: _provider.sortColumnIndex,
        sortColumnAsc: _provider.sortAscending,
      ),
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
