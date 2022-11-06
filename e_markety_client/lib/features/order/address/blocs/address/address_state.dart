part of 'address_bloc.dart';

abstract class AddressState {}

class AddressInitial implements AddressState {}

class AddressLoading implements AddressState {}

class AddressEditSuccess implements AddressState {
  final Address address;

  AddressEditSuccess(this.address);
}

class AddressAddSuccess implements AddressState {}

class AddressDeletedSuccess implements AddressState {}

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
