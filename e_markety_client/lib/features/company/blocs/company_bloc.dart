import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/company.dart';
import '../services/company_service.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  final ICompanyService _service;

  CompanyBloc(this._service) : super(CompanyInitial()) {
    on<CompanyGetAllEvent>(_onGetAll);
    on<CompanyGetCurrentEvent>(_onGetCurrent);
    on<CompanyUpdateEvent>(_onUpdate);
  }

  Future<void> _onGetAll(event, emit) async {
    emit(CompanyLoadingState());
    final response = await _service.getCompanies();
    response.fold(
      (l) => emit(CompanyErrorState(l.message)),
      (r) => emit(CompanyLoadedListState(r)),
    );
  }

  Future<void> _onGetCurrent(event, emit) async {
    emit(CompanyLoadingState());
    final response = await _service.getCurrentCompany();
    response.fold(
      (l) => emit(CompanyErrorState(l.message)),
      (r) => emit(CompanyLoadedCurrentState(r)),
    );
  }

  Future<void> _onUpdate(CompanyUpdateEvent event, emit) async {
    emit(CompanyLoadingState());
    final response = await _service.updateCompany(event.company);
    response.fold(
      (l) => emit(CompanyErrorState(l.message)),
      (r) {
        emit(CompanySuccessState());
        emit(CompanyLoadedCurrentState(r));
      },
    );
  }
}
