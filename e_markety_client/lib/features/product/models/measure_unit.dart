import 'package:json_annotation/json_annotation.dart';

part 'measure_unit.g.dart';

@JsonSerializable()
class MeasureUnit {
  final int id;
  final String description;

  const MeasureUnit({
    required this.id,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': description,
    };
  }

  factory MeasureUnit.fromMap(Map<String, dynamic> map) {
    return MeasureUnit(
      id: map['id'],
      description: map['descricao'],
    );
  }

  @override
  String toString() {
    return 'MeasureUnit{id: $id, description: $description}';
  }

  factory MeasureUnit.fromJson(Map<String, dynamic> json) =>
      _$MeasureUnitFromJson(json);

  Map<String, dynamic> toJson() => _$MeasureUnitToJson(this);
}
