part of 'company_district_bloc.dart';

abstract class CompanyDistrictEvent {}

class CompanyDistrictCalculateTaxEvent implements CompanyDistrictEvent {
  final int districtId;

  CompanyDistrictCalculateTaxEvent(this.districtId);
}
