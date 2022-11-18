// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'predict_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictResponse _$PredictResponseFromJson(Map<String, dynamic> json) =>
    PredictResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PredictResponseToJson(PredictResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      name: json['name'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      isCached: json['isCached'] as bool,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'isCached': instance.isCached,
    };
