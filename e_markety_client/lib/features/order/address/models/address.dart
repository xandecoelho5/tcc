import 'package:e_markety_client/features/order/address/models/tag.dart';

import 'district.dart';

class Address {
  final int id;
  final Tag tag;
  final String name;
  final String phone;
  final String street;
  final District district; // Bairro
  final String? reference;
  final bool isDefault;

  const Address({
    required this.id,
    required this.tag,
    required this.name,
    required this.phone,
    required this.street,
    required this.district,
    this.reference,
    this.isDefault = false,
  });

  String get fullAddress => '$street, ${district.name}';

  factory Address.fromMap(dynamic map) {
    return Address(
      id: map['id'],
      tag: Tag.fromString(map['tag']),
      name: map['nome'],
      phone: map['telefone'],
      street: map['rua'],
      district: District.fromMap(map['bairro']),
      reference: map['referencia'],
      isDefault: map['padrao'],
    );
  }
}
