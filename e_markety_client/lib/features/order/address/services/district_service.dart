import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/order/address/exceptions/district_exception.dart';
import 'package:e_markety_client/features/order/address/models/district.dart';

abstract class IDistrictService {
  Future<Either<DistrictException, List<District>>> getDistricts();

  Future<Either<DistrictException, List<District>>>
      getDistrictsWithoutCurrentCompany();
}

class DistrictService implements IDistrictService {
  final IHttpService _httpService;
  final _baseUrl = '/bairro';

  DistrictService(this._httpService);

  @override
  Future<Either<DistrictException, List<District>>> getDistricts() async {
    final response = await _httpService.getAll('$_baseUrl?size=50');
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => Right(r.map(District.fromMap).toList()),
    );
  }

  @override
  Future<Either<DistrictException, List<District>>>
      getDistrictsWithoutCurrentCompany() async {
    final response = await _httpService.getAll('$_baseUrl/sem-empresa-atual');
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => Right(r.map(District.fromMap).toList()),
    );
  }
}
