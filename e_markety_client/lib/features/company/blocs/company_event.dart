part of 'company_bloc.dart';

abstract class CompanyEvent {}

class CompanyGetAllEvent implements CompanyEvent {}

class CompanyGetCurrentEvent implements CompanyEvent {}

class CompanyUpdateEvent implements CompanyEvent {
  final Company company;

  CompanyUpdateEvent(this.company);
}
