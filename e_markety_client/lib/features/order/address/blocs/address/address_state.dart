part of 'address_bloc.dart';

abstract class AddressState {}

class AddressInitial implements AddressState {}

class AddressLoading implements AddressState {}

class AddressSuccess implements AddressState {
  final Address address;

  AddressSuccess(this.address);
}

class AddressListLoaded implements AddressState {
  final List<Address> addresses;

  AddressListLoaded(this.addresses);
}

class AddressLoaded implements AddressState {
  final Address address;

  AddressLoaded(this.address);
}

class AddressError implements AddressState {
  final String message;

  AddressError(this.message);
}
