import 'package:keyboard/core/abstracts/repository.dart';
import 'package:keyboard/core/dtos/prediction_get_dto.dart';

abstract class IPredictionRepository extends IRepository {
  IPredictionRepository(super.consumer);

  Future<PredictionGetDto> getPrediction(String uid, String language, String text, String model);
}
