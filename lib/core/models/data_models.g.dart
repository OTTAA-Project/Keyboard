// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModels _$DataModelsFromJson(Map<String, dynamic> json) => DataModels(
      uid: json['uid'] as String,
      name: json['name'] as String,
      language: json['language'] as String,
      models:
          (json['models'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DataModelsToJson(DataModels instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'language': instance.language,
      'models': instance.models,
    };
