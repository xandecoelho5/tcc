part of 'company_district_bloc.dart';

abstract class CompanyDistrictState {}

class CompanyDistrictInitial implements CompanyDistrictState {}

class CompanyDistrictLoadingState implements CompanyDistrictState {}

class CompanyDistrictSuccessState implements CompanyDistrictState {
  final double tax;

  CompanyDistrictSuccessState(this.tax);
}

class CompanyDistrictErrorState implements CompanyDistrictState {
  final String message;

  CompanyDistrictErrorState(this.message);
}
