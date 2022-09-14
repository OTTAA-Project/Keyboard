import 'package:json_annotation/json_annotation.dart';

part 'predict_response_model.g.dart';

@JsonSerializable()
class PredictResponse {
  PredictResponse({
    required this.source,
    this.results,
  });

  String source;
  @JsonKey(name: 'results', includeIfNull: true)
  List<Result?>? results;

  factory PredictResponse.fromJson(Map<String, dynamic> json) => _$PredictResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PredictResponseToJson(this);
}

@JsonSerializable()
class Result {
  Result({
    this.name,
    this.value,
    this.scores,
  });

  String? name;
  double? value;
  List<double>? scores;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  String toString() {
    return 'Result{name: $name, value: $value, scores: $scores}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is Result && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
