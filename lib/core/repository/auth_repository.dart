import 'dart:async';

import 'package:keyboard/core/enums/sign_in_types.dart';
import 'package:keyboard/core/models/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel?> signIn(SignInTypes signInType, {dynamic payload});

  Future<String> signUp({dynamic payload});

  Future<UserModel?> getCurrentUser();

  Future<bool> isLoggedIn();

  Future<void> logout();
}
