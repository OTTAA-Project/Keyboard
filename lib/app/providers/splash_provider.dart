import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  late SharedPreferences _sharedPref;
  // late bool _isUserLogIn;
  late BuildContext context;

  final auth = FirebaseAuth.instance;

  SplashProvider() {
    _inIt();
  }

  void _inIt() async {}

  Future<bool> get isUserLogIn async {
    _sharedPref = await SharedPreferences.getInstance();

    if (auth.currentUser == null) {
      await _sharedPref.clear();
      return false;
    }

    return _sharedPref.getBool(isLoggedInString) ?? false;
  }
}
