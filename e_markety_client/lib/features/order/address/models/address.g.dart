// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as int?,
      tag: $enumDecode(_$TagEnumMap, json['tag']),
      name: json['name'] as String,
      phone: json['phone'] as String,
      street: json['street'] as String,
      district: json['district'] == null
          ? null
          : District.fromJson(json['district'] as Map<String, dynamic>),
      reference: json['reference'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'tag': _$TagEnumMap[instance.tag]!,
      'name': instance.name,
      'phone': instance.phone,
      'street': instance.street,
      'district': instance.district?.toJson(),
      'reference': instance.reference,
      'isDefault': instance.isDefault,
    };

const _$TagEnumMap = {
  Tag.home: 'home',
  Tag.office: 'office',
  Tag.other: 'other',
};
