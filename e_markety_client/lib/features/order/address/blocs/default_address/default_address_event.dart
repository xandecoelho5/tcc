part of 'default_address_bloc.dart';

abstract class DefaultAddressEvent {}

class DefaultAddressGetEvent implements DefaultAddressEvent {
  final Function(Address)? onCompleted;

  DefaultAddressGetEvent({this.onCompleted});
}
