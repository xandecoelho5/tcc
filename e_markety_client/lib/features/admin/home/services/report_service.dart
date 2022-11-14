import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';

import '../exceptions/report_exception.dart';
import '../models/status_summary.dart';

abstract class IReportService {
  Future<Either<ReportException, List<StatusSummary>>> getStatusSummary();
}

class ReportService implements IReportService {
  final IHttpService _httpService;
  final String _baseUrl = '/pedido/relatorio';

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
}
