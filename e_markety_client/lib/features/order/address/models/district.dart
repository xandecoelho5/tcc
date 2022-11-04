import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'district.g.dart';

@JsonSerializable()
class District extends Equatable {
  final int id;
  final String name;

  const District({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
    };
  }

  factory District.fromMap(dynamic map) {
    return District(
      id: map['id'],
      name: map['nome'],
    );
  }

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictToJson(this);

  @override
  String toString() => name;

  @override
  List<Object?> get props => [id];
}
