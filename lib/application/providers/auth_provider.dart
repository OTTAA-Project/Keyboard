import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keyboard/core/enums/sign_in_types.dart';
import 'package:keyboard/core/models/user_model.dart';
import 'package:keyboard/core/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;

  final IAuthRepository authRepository;

  AuthProvider(this.authRepository);

  Future<UserModel?> trySignIn() async {
    isLoading = true;
    notifyListeners();

    final UserModel? user = await authRepository.signIn(SignInTypes.google);

    if (user != null) {
      isLoading = false;
      notifyListeners();
      return user;
    }

    isLoading = false;

    notifyListeners();
    return null;
  }

  Future<void> signOut() async {
    isLoading = true;
    notifyListeners();

    await authRepository.logout();

    isLoading = false;
    notifyListeners();
  }
}
