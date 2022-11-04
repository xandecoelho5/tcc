import 'package:dartz/dartz.dart';
import 'package:e_markety_client/core/services/http/http_service.dart';
import 'package:e_markety_client/features/company/models/company.dart';

import '../exceptions/company_exception.dart';

abstract class ICompanyService {
  Future<Either<CompanyException, List<Company>>> getCompanies();

  Future<Either<CompanyException, Company>> getCurrentCompany();

  Future<Either<CompanyException, Company>> updateCompany(Company company);
}

class CompanyService implements ICompanyService {
  final IHttpService _httpService;
  final _baseUrl = '/empresa';

  CompanyService(this._httpService);

  @override
  Future<Either<CompanyException, List<Company>>> getCompanies() async {
    final response = await _httpService.getAll(_baseUrl);
    return response.fold(
      (l) => Left(CompanyException(l.message)),
      (r) => Right(r.map(Company.fromMap).toList()),
    );
  }

  @override
  Future<Either<CompanyException, Company>> getCurrentCompany() async {
    final response = await _httpService.get('$_baseUrl/current');
    return response.fold(
      (l) => Left(CompanyException(l.message)),
      (r) => Right(Company.fromMap(r)),
    );
  }

  @override
  Future<Either<CompanyException, Company>> updateCompany(
    Company company,
  ) async {
    final response = await _httpService.put(
      '$_baseUrl/${company.id}',
      company.toMap(),
    );
    return response.fold(
      (l) => Left(CompanyException(l.message)),
      (r) => Right(Company.fromMap(r)),
    );
  }
}
