import 'package:flutter/material.dart';
import 'package:keyboard/core/repository/auth_repository.dart';

class SplashProvider extends ChangeNotifier {
  final IAuthRepository authRepository;

  SplashProvider(this.authRepository);

  Future<bool> get isUserLogIn async {
    return (await authRepository.getCurrentUser()) != null;
  }
}
