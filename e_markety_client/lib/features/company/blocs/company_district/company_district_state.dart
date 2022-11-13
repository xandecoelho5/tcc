part of 'company_district_bloc.dart';

abstract class CompanyDistrictState {}

class CompanyDistrictInitial implements CompanyDistrictState {}

class CompanyDistrictLoading implements CompanyDistrictState {}

class CompanyDistrictSuccess implements CompanyDistrictState {}

class CompanyDistrictDeleteSuccess implements CompanyDistrictState {}

class CompanyDistrictLoaded implements CompanyDistrictState {
  final CompanyDistrict companyDistrict;

  CompanyDistrictLoaded(this.companyDistrict);
}

class CompanyDistrictTaxSuccess implements CompanyDistrictState {
  final double tax;

  CompanyDistrictTaxSuccess(this.tax);
}

class CompanyDistrictError implements CompanyDistrictState {
  final String message;

  CompanyDistrictError(this.message);
}
