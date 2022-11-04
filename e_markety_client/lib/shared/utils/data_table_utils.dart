import 'package:e_markety_client/features/admin/shared/widgets/custom_notifier.dart';

class DataTableUtils {
  DataTableUtils._();

  static void sort(
    CustomNotifier provider,
    List sortColumns,
    int columnIndex,
    bool ascending,
  ) {
    final columnName = sortColumns[columnIndex];
    provider
      ..sortAscending = ascending
      ..sortColumnIndex = columnIndex
      ..sortColumnName = columnName
      ..fetchData();
  }
}
