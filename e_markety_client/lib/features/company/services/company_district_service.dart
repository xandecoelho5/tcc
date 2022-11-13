import 'package:dartz/dartz.dart';
import 'package:e_markety_client/features/admin/shared/data_responses/company_district_page_response.dart';
import 'package:e_markety_client/features/admin/shared/services/paginated_service.dart';
import 'package:e_markety_client/features/company/models/company_district.dart';
import 'package:e_markety_client/features/order/address/exceptions/district_exception.dart';

import '../../../core/services/http/http_service.dart';

abstract class ICompanyDistrictService extends IPaginatedService {
  Future<Either<DistrictException, List<CompanyDistrict>>>
      getCompanyDistricts();

  Future<Either<DistrictException, double>> getDistrictTax(int id);

  Future<Either<DistrictException, CompanyDistrict>> getCompanyDistrictById(
    int id,
  );

  Future<Either<DistrictException, void>> addCompanyDistrict(
    CompanyDistrict companyDistrict,
  );

  Future<Either<DistrictException, void>> editCompanyDistrict(
    CompanyDistrict companyDistrict,
  );

  Future<Either<DistrictException, void>> deleteCompanyDistrict(int id);
}

class CompanyDistrictService implements ICompanyDistrictService {
  final IHttpService _httpService;
  final _baseUrl = '/empresa-bairro';

  CompanyDistrictService(this._httpService);

  @override
  Future<Either<DistrictException, List<CompanyDistrict>>>
      getCompanyDistricts() async {
    final response = await _httpService.getAll('$_baseUrl?size=0');
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => Right(r.map(CompanyDistrict.fromMap).toList()),
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

  @override
  Future<Either<DistrictException, CompanyDistrictPageResponse>> getPaginated({
    required int page,
    required int size,
    String? order,
    bool? asc,
  }) async {
    final response =
        await _httpService.get('$_baseUrl/page?page=$page&size=$size'
            '${order != null ? '&order=$order' : ''}'
            '${asc != null ? '&asc=$asc' : ''}');
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => Right(CompanyDistrictPageResponse.fromMap(r)),
    );
  }

  @override
  Future<Either<DistrictException, void>> addCompanyDistrict(
    CompanyDistrict companyDistrict,
  ) async {
    final response = await _httpService.post(_baseUrl, companyDistrict.toMap());
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<DistrictException, void>> editCompanyDistrict(
    CompanyDistrict companyDistrict,
  ) async {
    final response = await _httpService.put(
      '$_baseUrl/${companyDistrict.id}',
      companyDistrict.toMap(),
    );
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => const Right(null),
    );
  }

  @override
  Future<Either<DistrictException, CompanyDistrict>> getCompanyDistrictById(
    int id,
  ) async {
    final response = await _httpService.get('$_baseUrl/$id');
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => Right(CompanyDistrict.fromMap(r)),
    );
  }

  @override
  Future<Either<DistrictException, void>> deleteCompanyDistrict(int id) async {
    final response = await _httpService.delete('$_baseUrl/$id');
    return response.fold(
      (l) => Left(DistrictException(l.message)),
      (r) => const Right(null),
    );
  }
}
