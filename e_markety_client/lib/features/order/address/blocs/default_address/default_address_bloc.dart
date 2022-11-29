import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/address.dart';
import '../../services/address_service.dart';

part 'default_address_event.dart';
part 'default_address_state.dart';

class DefaultAddressBloc
    extends Bloc<DefaultAddressEvent, DefaultAddressState> {
  final IAddressService _addressService;

  DefaultAddressBloc(this._addressService) : super(DefaultAddressInitial()) {
    on<DefaultAddressGetEvent>(_onDefaultAddressGetEvent);
  }

  Future<void> _onDefaultAddressGetEvent(event, emit) async {
    final addresses = await _addressService.getDefaultAddress();
    addresses.fold(
      (l) => emit(DefaultAddressError(l.message)),
      (r) {
        emit(DefaultAddressLoaded(r));
        event.onCompleted?.call(r);
      },
    );
  }
}
