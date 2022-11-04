import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/order/address/exceptions/district_exception.dart';
import 'package:e_markety_client/features/order/address/models/district.dart';

abstract class IDistrictService {
  Future<Either<DistrictException, List<District>>> getDistricts();
}

class DistrictService implements IDistrictService {
  final IHttpService _httpService;
  final _baseUrl = '/bairro';

  DistrictService(this._httpService);

  @override
  Future<Either<DistrictException, List<District>>> getDistricts() async {
    final response = await _httpService.getAll('$_baseUrl?size=0');
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => Right(r.map(District.fromMap).toList()),
    );
  }
}
