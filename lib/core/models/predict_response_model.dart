import 'package:json_annotation/json_annotation.dart';

part 'predict_response_model.g.dart';

@JsonSerializable()
class PredictResponse {
  const PredictResponse({
    this.data,
  });

  @JsonKey(name: 'data', includeIfNull: true)
  final List<Result?>? data;

  factory PredictResponse.fromJson(Map<String, dynamic> json) => _$PredictResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PredictResponseToJson(this);
}

@JsonSerializable()
class Result {
  const Result({
    this.name,
    this.value,
    required this.isCached,
  });

  final String? name;
  final double? value;
  final bool isCached;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  String toString() {
    return name ?? '';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is Result && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
