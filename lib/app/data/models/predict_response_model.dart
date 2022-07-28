import 'package:json_annotation/json_annotation.dart';

part 'predict_response_model.g.dart';

@JsonSerializable()
class PredictResponse {
  PredictResponse({
    required this.source,
    this.results,
  });

  String source;
  @JsonKey(name: 'results',nullable: true)
  List<Result?>? results;

  factory PredictResponse.fromJson(Map<String, dynamic> json) =>
      _$PredictResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PredictResponseToJson(this);
}

@JsonSerializable()
class Result {
  Result({
    this.name,
    this.value,
  });

  String? name;
  List<double?>? value;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
