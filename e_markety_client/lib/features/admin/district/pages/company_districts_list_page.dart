import 'package:e_markety_client/features/admin/district/datasources/company_district_datasource.dart';
import 'package:e_markety_client/features/admin/shared/data_responses/company_district_page_response.dart';
import 'package:e_markety_client/features/company/blocs/company_district/company_district_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/utils/data_table_utils.dart';
import '../../../../shared/utils/modular_utils.dart';
import '../../../../shared/widgets/custom_data_table/custom_paginated_table.dart';
import '../../shared/data_responses/provider_settings.dart';
import '../../shared/widgets/empty_container.dart';
import '../components/company_district_notifier.dart';

final sortColumns = ['bairro_nome', 'taxaEntrega'];

class CompanyDistrictsListPage extends StatefulWidget {
  const CompanyDistrictsListPage({Key? key}) : super(key: key);

  @override
  State<CompanyDistrictsListPage> createState() =>
      _CompanyDistrictsListPageState();
}

class _CompanyDistrictsListPageState extends State<CompanyDistrictsListPage> {
  final _provider = Modular.get<CompanyDistrictNotifier>();

  @override
  void didChangeDependencies() {
    _provider.fetchData();
    super.didChangeDependencies();
  }

  void sort(int columnIndex, bool ascending) {
    DataTableUtils.sort(_provider, sortColumns, columnIndex, ascending);
  }

  List<DataColumn> _buildDataColumns() {
    return [
      DataColumn(label: const Text('Nome'), onSort: sort),
      DataColumn(
        label: const Text('Taxa de Entrega'),
        numeric: true,
        onSort: sort,
      ),
      const DataColumn(label: Text('Ações')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyDistrictBloc, CompanyDistrictState>(
      bloc: Modular.get<CompanyDistrictBloc>(),
      listener: (context, state) {
        if (state is CompanyDistrictDeleteSuccess) {
          _provider.fetchData();
          ModularUtils.showSuccess('Bairro excluído com sucesso');
        }
        if (state is CompanyDistrictError) {
          ModularUtils.showError('Erro ao excluir bairro: ${state.message}');
        }
      },
      child: ValueListenableBuilder<ProviderSettings>(
        valueListenable: _provider,
        builder: (context, value, child) {
          final _dataSource = CompanyDistrictDataSource(
            value.pageResponse as CompanyDistrictPageResponse,
          );

          if (value.pageResponse.content.isEmpty) {
            return const EmptyContainer();
          }

          return CustomPaginatedTable(
            dataColumns: _buildDataColumns(),
            header: const Text('Bairros'),
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
