import 'package:e_markety_client/features/order/address/models/tag.dart';

class Address {
  final int id;
  final Tag tag;
  final String name;
  final String phone;
  final String address;
  final String district; // Bairro
  final String city;
  final String zipcode; // CEP
  final bool isDefault;

  const Address({
    required this.id,
    required this.tag,
    required this.name,
    required this.phone,
    required this.address,
    required this.district,
    required this.city,
    required this.zipcode,
    this.isDefault = false,
  });

  String get fullAddress => '$address, $district, $city - $zipcode';
}
