import 'package:keyboard/core/abstracts/dto.dart';
import 'package:keyboard/core/models/predict_response_model.dart';

class PredictionGetDto extends DTO<PredictResponse> {

  PredictionGetDto(super.status, super.message, {super.data});

}
