part of 'default_address_bloc.dart';

abstract class DefaultAddressState {}

class DefaultAddressInitial implements DefaultAddressState {}

class DefaultAddressSuccess implements DefaultAddressState {
  final Address address;

  DefaultAddressSuccess(this.address);
}

class DefaultAddressError implements DefaultAddressState {
  final String message;

  DefaultAddressError(this.message);
}
