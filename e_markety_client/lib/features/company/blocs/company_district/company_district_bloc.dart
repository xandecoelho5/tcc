import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/company_district.dart';
import '../../services/company_district_service.dart';

part 'company_district_event.dart';
part 'company_district_state.dart';

class CompanyDistrictBloc
    extends Bloc<CompanyDistrictEvent, CompanyDistrictState> {
  final ICompanyDistrictService _service;

  CompanyDistrictBloc(this._service) : super(CompanyDistrictInitial()) {
    on<CompanyDistrictGetByIdEvent>(_onGetById);
    on<CompanyDistrictAddEvent>(_onAdd);
    on<CompanyDistrictEditEvent>(_onEdit);
    on<CompanyDistrictDeleteByIdEvent>(_onDeleteById);
    on<CompanyDistrictCalculateTaxEvent>(_onCalculateTax);
  }

  Future<void> _onCalculateTax(
    CompanyDistrictCalculateTaxEvent event,
    emit,
  ) async {
    emit(CompanyDistrictLoading());
    final response = await _service.getDistrictTax(event.districtId);
    response.fold(
      (l) => emit(CompanyDistrictError(l.message)),
      (r) => emit(CompanyDistrictTaxSuccess(r)),
    );
  }

  Future<void> _onGetById(CompanyDistrictGetByIdEvent event, emit) async {
    emit(CompanyDistrictLoading());
    final response = await _service.getCompanyDistrictById(event.id);
    response.fold(
      (l) => emit(CompanyDistrictError(l.message)),
      (r) => emit(CompanyDistrictLoaded(r)),
    );
  }

  Future<void> _onAdd(CompanyDistrictAddEvent event, emit) async {
    emit(CompanyDistrictLoading());
    final response = await _service.addCompanyDistrict(event.companyDistrict);
    response.fold(
      (l) => emit(CompanyDistrictError(l.message)),
      (r) => emit(CompanyDistrictSuccess()),
    );
  }

  Future<void> _onEdit(CompanyDistrictEditEvent event, emit) async {
    emit(CompanyDistrictLoading());
    final response = await _service.editCompanyDistrict(event.companyDistrict);
    response.fold(
      (l) => emit(CompanyDistrictError(l.message)),
      (r) => emit(CompanyDistrictSuccess()),
    );
  }

  Future<void> _onDeleteById(CompanyDistrictDeleteByIdEvent event, emit) async {
    emit(CompanyDistrictLoading());
    final response = await _service.deleteCompanyDistrict(event.id);
    response.fold(
      (l) => emit(CompanyDistrictError(l.message)),
      (r) => emit(CompanyDistrictDeleteSuccess()),
    );
  }
}
