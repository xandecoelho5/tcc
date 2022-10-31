import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/admin/product/exceptions/measure_unit_exception.dart';

import '../../../product/models/measure_unit.dart';

abstract class IMeasureUnitService {
  Future<Either<MeasureUnitException, List<MeasureUnit>>> getMeasureUnits();
}

class MeasureUnitService implements IMeasureUnitService {
  final IHttpService _httpService;
  final String _baseUrl = '/unidade-medida';

  MeasureUnitService(this._httpService);

  @override
  Future<Either<MeasureUnitException, List<MeasureUnit>>>
      getMeasureUnits() async {
    final response = await _httpService.getAll(_baseUrl);
    return response.fold(
      (l) => Left(throw MeasureUnitException(l.message)),
      (r) => Right(r.map(MeasureUnit.fromMap).toList()),
    );
  }
}
