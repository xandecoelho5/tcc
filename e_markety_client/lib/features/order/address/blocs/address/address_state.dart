part of 'address_bloc.dart';

abstract class AddressState {}

class AddressInitial implements AddressState {}

class AddressLoading implements AddressState {}

class AddressLoaded implements AddressState {
  final List<Address> addresses;

  AddressLoaded(this.addresses);
}

class AddressError implements AddressState {
  final String message;

  AddressError(this.message);
}
