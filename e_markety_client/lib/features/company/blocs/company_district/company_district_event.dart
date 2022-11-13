part of 'company_district_bloc.dart';

abstract class CompanyDistrictEvent {}

class CompanyDistrictGetByIdEvent extends CompanyDistrictEvent {
  final int id;

  CompanyDistrictGetByIdEvent(this.id);
}

class CompanyDistrictAddEvent extends CompanyDistrictEvent {
  final CompanyDistrict companyDistrict;

  CompanyDistrictAddEvent(this.companyDistrict);
}

class CompanyDistrictEditEvent extends CompanyDistrictEvent {
  final CompanyDistrict companyDistrict;

  CompanyDistrictEditEvent(this.companyDistrict);
}

class CompanyDistrictDeleteByIdEvent extends CompanyDistrictEvent {
  final int id;

  CompanyDistrictDeleteByIdEvent(this.id);
}

class CompanyDistrictCalculateTaxEvent implements CompanyDistrictEvent {
  final int districtId;

  CompanyDistrictCalculateTaxEvent(this.districtId);
}
