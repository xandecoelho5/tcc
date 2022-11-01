import 'package:e_markety_client/features/admin/shared/data_responses/page_response.dart';

class ProviderSettings {
  final int rowsPerPage;
  final String sortColumnName;
  final int sortColumnIndex;
  final bool sortAscending;
  final int currentPage;
  final PageResponse pageResponse;

  const ProviderSettings({
    required this.rowsPerPage,
    required this.sortColumnName,
    required this.pageResponse,
    this.sortColumnIndex = 0,
    this.sortAscending = true,
    this.currentPage = 0,
  });

  ProviderSettings copyWith({
    int? rowsPerPage,
    String? sortColumnName,
    int? sortColumnIndex,
    bool? sortAscending,
    int? currentPage,
    PageResponse? pageResponse,
  }) {
    return ProviderSettings(
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      sortColumnName: sortColumnName ?? this.sortColumnName,
      sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
      sortAscending: sortAscending ?? this.sortAscending,
      currentPage: currentPage ?? this.currentPage,
      pageResponse: pageResponse ?? this.pageResponse,
    );
  }
}
