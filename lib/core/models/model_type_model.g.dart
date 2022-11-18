// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelTypeModel _$ModelTypeModelFromJson(Map<String, dynamic> json) =>
    ModelTypeModel(
      name: json['name'] as String,
      value: (json['value'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ModelTypeModelToJson(ModelTypeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };
