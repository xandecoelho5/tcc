import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/company_district_service.dart';

part 'company_district_event.dart';
part 'company_district_state.dart';

class CompanyDistrictBloc
    extends Bloc<CompanyDistrictEvent, CompanyDistrictState> {
  final ICompanyDistrictService _service;

  CompanyDistrictBloc(this._service) : super(CompanyDistrictInitial()) {
    on<CompanyDistrictCalculateTaxEvent>(_onCalculateTax);
  }

  Future<void> _onCalculateTax(
    CompanyDistrictCalculateTaxEvent event,
    emit,
  ) async {
    emit(CompanyDistrictLoadingState());
    final response = await _service.getDistrictTax(event.districtId);
    response.fold(
      (l) => emit(CompanyDistrictErrorState(l.message)),
      (r) => emit(CompanyDistrictSuccessState(r)),
    );
  }
}
