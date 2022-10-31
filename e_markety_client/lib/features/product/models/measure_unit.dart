import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'measure_unit.g.dart';

@JsonSerializable()
class MeasureUnit extends Equatable {
  final int id;
  final String abbreviation;
  final String description;

  const MeasureUnit({
    required this.id,
    required this.abbreviation,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'abreviatura': abbreviation,
      'descricao': description,
    };
  }

  factory MeasureUnit.fromMap(dynamic map) {
    return MeasureUnit(
      id: map['id'],
      abbreviation: map['abreviatura'],
      description: map['descricao'],
    );
  }

  @override
  String toString() => '$abbreviation - $description';

  factory MeasureUnit.fromJson(Map<String, dynamic> json) =>
      _$MeasureUnitFromJson(json);

  Map<String, dynamic> toJson() => _$MeasureUnitToJson(this);

  @override
  List<Object?> get props => [id];
}
