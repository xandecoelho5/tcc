part of 'company_bloc.dart';

abstract class CompanyState {}

class CompanyInitial implements CompanyState {}

class CompanyLoadingState implements CompanyState {}

class CompanySuccessState implements CompanyState {}

class CompanyLoadedListState implements CompanyState {
  final List<Company> companies;

  CompanyLoadedListState(this.companies);
}

class CompanyLoadedCurrentState implements CompanyState {
  final Company company;

  CompanyLoadedCurrentState(this.company);
}

class CompanyErrorState implements CompanyState {
  final String message;

  CompanyErrorState(this.message);
}
