import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/address.dart';
import '../../services/address_service.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final IAddressService _addressService;

  AddressBloc(this._addressService) : super(AddressInitial()) {
    on<AddressGetAllEvent>(_onAddressGetAllEvent);
  }

  Future<void> _onAddressGetAllEvent(AddressGetAllEvent event, emit) async {
    emit(AddressLoading());
    final addresses = await _addressService.getAddresses();
    addresses.fold(
      (l) => emit(AddressError(l.message)),
      (r) => emit(AddressLoaded(r)),
    );
  }
}
