import '../../order/address/models/district.dart';

class CompanyDistrict {
  final int? id;
  final District? district;
  final double deliveryCharge;

  const CompanyDistrict({
    required this.id,
    required this.district,
    required this.deliveryCharge,
  });

  const CompanyDistrict.empty({
    this.id,
    this.district,
    this.deliveryCharge = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bairro': district?.toMap(),
      'taxaEntrega': deliveryCharge,
    };
  }

  factory CompanyDistrict.fromMap(dynamic map) {
    return CompanyDistrict(
      id: map['id'],
      district: District.fromMap(map['bairro']),
      deliveryCharge: map['taxaEntrega'],
    );
  }

  CompanyDistrict copyWith({
    int? id,
    District? district,
    double? deliveryCharge,
  }) {
    return CompanyDistrict(
      id: this.id,
      district: district ?? this.district,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
    );
  }
}
