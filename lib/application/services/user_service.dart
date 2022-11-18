import 'package:keyboard/core/dtos/user_post_dto.dart';
import 'package:keyboard/core/dtos/models_get_dto.dart';
import 'package:keyboard/core/abstracts/consumer.dart';
import 'package:keyboard/core/entities/response.dart';
import 'package:keyboard/core/models/data_models.dart';
import 'package:keyboard/core/repository/users_repository.dart';

class UserService implements IUserRepository {
  @override
  final Consumer consumer;

  const UserService(this.consumer);

  @override
  Future<ModelsGetDto> getModels(String uid, String language) async {
    final ResponseEntity response = await consumer.get("/users/models?uid=$uid&language=$language");
    DataModels? data;

    if (response.statusCode == 200) data = DataModels.fromJson(response.data);

    return ModelsGetDto(response.statusCode, response.statusMessage, data: data);
  }

  @override
  Future<void> learnText(String uid, String language, String text, String model) async {
    await consumer.post(url: "/users/learn", data: {
      "uid": uid,
      "language": language,
      "sentence": text,
      "model": model,
    });
  }

  @override
  Future<UserPostDto> saveUser(String uid) async {
    final ResponseEntity response = await consumer.post(
      url: "/users",
      data: {"uid": uid},
    );

    return UserPostDto(response.statusCode, response.statusMessage, data: response.data);
  }
}
