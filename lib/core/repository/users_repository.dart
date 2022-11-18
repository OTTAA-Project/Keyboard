import 'package:keyboard/core/abstracts/repository.dart';
import 'package:keyboard/core/dtos/models_get_dto.dart';
import 'package:keyboard/core/dtos/user_post_dto.dart';

abstract class IUserRepository extends IRepository{
  IUserRepository(super.consumer);

  Future<UserPostDto> saveUser(String uid);

  Future<ModelsGetDto> getModels(String uid, String language);

  Future<void> learnText(String uid, String language, String text, String model);

}