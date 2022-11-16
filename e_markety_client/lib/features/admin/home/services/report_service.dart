import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/admin/home/models/monthly_orders.dart';
import 'package:e_markety_client/features/admin/home/models/products_sales.dart';

import '../exceptions/report_exception.dart';
import '../models/status_summary.dart';

abstract class IReportService {
  Future<Either<ReportException, List<StatusSummary>>> getStatusSummary();

  Future<Either<ReportException, List<ProductsSales>>> getProductsSales(
    String sort,
  );

  Future<Either<ReportException, List<MonthlyOrders>>> getMonthlyOrders();
}

class ReportService implements IReportService {
  final IHttpService _httpService;
  final String _baseUrl = '/relatorio';

  ReportService(this._httpService);

  @override
  Future<Either<ReportException, List<StatusSummary>>>
      getStatusSummary() async {
    final response = await _httpService.getAll('$_baseUrl/status');
    return response.fold(
      (l) => Left(ReportException(l.message)),
      (r) => Right(r.map(StatusSummary.fromMap).toList()),
    );
  }

  @override
  Future<Either<ReportException, List<ProductsSales>>> getProductsSales(
    String sort,
  ) async {
    final response = await _httpService.getAll('$_baseUrl/produtos?sort=$sort');
    return response.fold(
      (l) => Left(ReportException(l.message)),
      (r) => Right(r.map(ProductsSales.fromMap).toList()),
    );
  }

  @override
  Future<Either<ReportException, List<MonthlyOrders>>>
      getMonthlyOrders() async {
    final response = await _httpService.getAll('$_baseUrl/pedidos-ano');
    return response.fold(
      (l) => Left(ReportException(l.message)),
      (r) => Right(r.map(MonthlyOrders.fromMap).toList()),
    );
  }
}
