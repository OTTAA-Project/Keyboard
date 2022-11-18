import 'package:keyboard/core/dtos/prediction_get_dto.dart';
import 'package:keyboard/core/abstracts/consumer.dart';
import 'package:keyboard/core/entities/response.dart';
import 'package:keyboard/core/models/predict_response_model.dart';
import 'package:keyboard/core/repository/prediction_repository.dart';

class PredictionService implements IPredictionRepository {
  @override
  final Consumer consumer;

  const PredictionService(this.consumer);

  @override
  Future<PredictionGetDto> getPrediction(String uid, String language, String text, String model) async {
    final ResponseEntity response = await consumer.post(
      url: "/predict",
      data: {
        "uid": uid,
        "language": language,
        "sentence": text,
        "model": model,
      },
    );

    PredictResponse? data;

    if (response.statusCode == 200) {
      data = PredictResponse.fromJson(response.data);
    }

    return PredictionGetDto(response.statusCode, response.statusMessage, data: data);
  }
}
