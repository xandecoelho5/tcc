import 'package:flutter/material.dart';

class CustomPaginatedTable extends StatelessWidget {
  const CustomPaginatedTable({
    Key? key,
    this.rowsPerPage = PaginatedDataTable.defaultRowsPerPage,
    required this.source,
    required this.dataColumns,
    Widget? header,
    bool showActions = false,
    List<Widget>? actions,
    this.sortColumnIndex,
    this.sortColumnAsc = true,
    this.onRowChanged,
    this.onPageChanged,
  })  : _header = header,
        _showActions = showActions,
        _actions = actions,
        assert(
          sortColumnIndex == null ||
              (sortColumnIndex >= 0 && sortColumnIndex < dataColumns.length),
          'Check the sortColumnIndex value',
        ),
        super(key: key);

  final DataTableSource source;
  final List<DataColumn> dataColumns;

  final Widget? _header;
  final bool _showActions;
  final List<Widget>? _actions;
  final int rowsPerPage;
  final int? sortColumnIndex;
  final bool sortColumnAsc;

  final void Function(int? index)? onRowChanged;
  final void Function(int)? onPageChanged;

  Widget? get _fetchHeader {
    if (_header != null) {
      return _header!;
    }

    return null;
  }

  List<Widget>? get _fetchActions {
    if (_showActions && _actions != null) {
      return _actions!;
    } else if (!_showActions) {
      return null;
    }

    return _defAction;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Theme(
        data: Theme.of(context).copyWith(
          cardTheme: CardTheme(
            margin: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey.shade50),
            ),
            elevation: 2,
          ),
        ),
        child: PaginatedDataTable(
          dataRowHeight: 60,
          actions: _fetchActions,
          columns: dataColumns,
          header: _fetchHeader,
          onRowsPerPageChanged: onRowChanged,
          rowsPerPage: rowsPerPage,
          source: source,
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortColumnAsc,
          availableRowsPerPage: const [5, 10, 20],
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}

final _defAction = <Widget>[
  IconButton(
    icon: const Icon(Icons.info_outline),
    onPressed: () {},
  ),
];
