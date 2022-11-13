import 'package:e_markety_client/features/order/address/models/address.dart';

class Company {
  final int? id;
  final String name;
  final String phone;
  final String? cellPhone;
  final String logoUrl;
  final String? deliveryOpeningTime;
  final String? deliveryClosingTime;
  final String? storeOpeningTime;
  final String? storeClosingTime;
  final Address address;
  final List<String> banners;

  const Company({
    required this.id,
    required this.name,
    required this.phone,
    this.cellPhone,
    required this.logoUrl,
    this.deliveryOpeningTime,
    this.deliveryClosingTime,
    this.storeOpeningTime,
    this.storeClosingTime,
    required this.address,
    this.banners = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'telefone': phone,
      'celular': cellPhone,
      'logo': logoUrl,
      'deliveryAbertura': deliveryOpeningTime,
      'deliveryFechamento': deliveryClosingTime,
      'lojaAbertura': storeOpeningTime,
      'lojaFechamento': storeClosingTime,
      'endereco': address.toMap(),
      'banners': banners,
    };
  }

  factory Company.fromMap(map) {
    return Company(
      id: map['id'],
      name: map['nome'],
      phone: map['telefone'],
      cellPhone: map['celular'],
      logoUrl: map['logo'],
      deliveryOpeningTime: map['deliveryAbertura'],
      deliveryClosingTime: map['deliveryFechamento'],
      storeOpeningTime: map['lojaAbertura'],
      storeClosingTime: map['lojaFechamento'],
      address: Address.fromMap(map['endereco']),
      banners: (map['banners'] as List).map((e) => e.toString()).toList(),
    );
  }

  @override
  String toString() => name;

  Company copyWith({
    String? name,
    String? phone,
    String? cellPhone,
    String? logoUrl,
    String? deliveryOpeningTime,
    String? deliveryClosingTime,
    String? storeOpeningTime,
    String? storeClosingTime,
    Address? address,
    List<String>? banners,
  }) {
    return Company(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      cellPhone: cellPhone ?? this.cellPhone,
      logoUrl: logoUrl ?? this.logoUrl,
      deliveryOpeningTime: deliveryOpeningTime ?? this.deliveryOpeningTime,
      deliveryClosingTime: deliveryClosingTime ?? this.deliveryClosingTime,
      storeOpeningTime: storeOpeningTime ?? this.storeOpeningTime,
      storeClosingTime: storeClosingTime ?? this.storeClosingTime,
      address: address ?? this.address,
      banners: banners ?? this.banners,
    );
  }
}
