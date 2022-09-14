import 'package:json_annotation/json_annotation.dart';

part 'model_type_model.g.dart';

@JsonSerializable()
class ModelTypeModel {
  ModelTypeModel({
    required this.name,
    required this.value,
  });

  final String name;
  final List<String> value;

  factory ModelTypeModel.fromJson(Map<String, dynamic> json) => _$ModelTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelTypeModelToJson(this);
}
