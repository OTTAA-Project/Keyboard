import 'package:json_annotation/json_annotation.dart';

part 'data_models.g.dart';

@JsonSerializable()
class DataModels {
  final String uid;
  final String name;
  final String language;
  final List<String> models;

  const DataModels({
    required this.uid,
    required this.name,
    required this.language,
    required this.models,
  });

  factory DataModels.fromJson(Map<String, dynamic> json) => _$DataModelsFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelsToJson(this);
}
