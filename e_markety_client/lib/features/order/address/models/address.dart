import 'package:e_markety_client/features/order/address/models/tag.dart';
import 'package:json_annotation/json_annotation.dart';

import 'district.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  final int? id;
  final Tag tag;
  final String name;
  final String phone;
  final String street;
  final District? district; // Bairro
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

  const Address.empty({
    this.id,
    this.tag = Tag.other,
    this.name = '',
    this.phone = '',
    this.street = '',
    this.district,
    this.reference,
    this.isDefault = false,
  });

  String get fullAddress => '$street, ${district?.name}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tag': tag.toRemoteName(),
      'nome': name,
      'telefone': phone,
      'rua': street,
      'bairro': district,
      'referencia': reference,
      'padrao': isDefault,
    };
  }

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

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  Address copyWith({
    Tag? tag,
    String? name,
    String? phone,
    String? street,
    District? district,
    String? reference,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? id,
      tag: tag ?? this.tag,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      district: district ?? this.district,
      reference: reference ?? this.reference,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  String toString() {
    return 'Address{id: $id, tag: $tag, name: $name, phone: $phone, street: $street, district: $district, reference: $reference, isDefault: $isDefault}';
  }
}
