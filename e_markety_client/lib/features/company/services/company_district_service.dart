import 'package:dartz/dartz.dart';
import 'package:e_markety_client/features/order/address/exceptions/district_exception.dart';

import '../../../core/services/http/http_service.dart';
import '../../order/address/models/district.dart';

abstract class ICompanyDistrictService {
  Future<Either<DistrictException, List<District>>> getDistricts();

  Future<Either<DistrictException, double>> getDistrictTax(int id);
}

class CompanyDistrictService implements ICompanyDistrictService {
  final IHttpService _httpService;
  final _baseUrl = '/empresa/bairro';

  CompanyDistrictService(this._httpService);

  @override
  Future<Either<DistrictException, List<District>>> getDistricts() async {
    final response = await _httpService.getAll('$_baseUrl?size=0');
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => Right(r.map(District.fromMap).toList()),
    );
  }

  @override
  Future<Either<DistrictException, double>> getDistrictTax(int id) async {
    final response = await _httpService.get('$_baseUrl/taxa/$id');
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => Right(r as double),
    );
  }
}
