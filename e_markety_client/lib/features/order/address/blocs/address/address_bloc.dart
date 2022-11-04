import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/address.dart';
import '../../services/address_service.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final IAddressService _addressService;

  AddressBloc(this._addressService) : super(AddressInitial()) {
    on<AddressGetAllEvent>(_onGetAll);
    on<AddressGetByIdEvent>(_onGetById);
    on<AddressEditEvent>(_onEdit);
  }

  Future<void> _onGetAll(AddressGetAllEvent event, emit) async {
    emit(AddressLoading());
    final response = await _addressService.getAddresses();
    response.fold(
      (l) => emit(AddressError(l.message)),
      (r) => emit(AddressListLoaded(r)),
    );
  }

  Future<void> _onGetById(AddressGetByIdEvent event, emit) async {
    emit(AddressLoading());
    final response = await _addressService.getAddressById(event.id);
    response.fold(
      (l) => emit(AddressError(l.message)),
      (r) => emit(AddressLoaded(r)),
    );
  }

  Future<void> _onEdit(AddressEditEvent event, emit) async {
    emit(AddressLoading());
    final response = await _addressService.updateAddress(event.address);
    response.fold(
      (l) => emit(AddressError(l.message)),
      (r) {
        emit(AddressSuccess(r));
        emit(AddressLoaded(r));
      },
    );
  }
}
