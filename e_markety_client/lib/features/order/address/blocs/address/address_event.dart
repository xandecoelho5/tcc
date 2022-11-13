part of 'address_bloc.dart';

abstract class AddressEvent {}

class AddressGetAllEvent implements AddressEvent {}

class AddressGetByIdEvent implements AddressEvent {
  final int id;

  AddressGetByIdEvent(this.id);
}

class AddressEditEvent implements AddressEvent {
  final Address address;

  AddressEditEvent(this.address);
}

class AddressAddEvent implements AddressEvent {
  final Address address;
  final bool getDefault;

  AddressAddEvent(this.address, {this.getDefault = false});
}

class AddressDeleteByIdEvent implements AddressEvent {
  final int id;

  AddressDeleteByIdEvent(this.id);
}
