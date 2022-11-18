import 'package:keyboard/core/models/user_model.dart';

abstract class LocalDatabase {
  UserModel? get user;
  set user(UserModel? user);

  Future<void> init();
  Future<void> close();

  Future<void> setUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> deleteUser();
}
