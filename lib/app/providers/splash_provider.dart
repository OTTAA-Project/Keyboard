import 'package:flutter/material.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  late SharedPreferences _sharedPref;
  // late bool _isUserLogIn;
  late BuildContext context;

  /*SplashProvider() {
    _inIt();
  }

  void _inIt() async {

    // await isUserLogIn();
  }*/

  Future<bool> get isUserLogIn async {
    _sharedPref = await SharedPreferences.getInstance();
    await Future.delayed(
      const Duration(seconds: 2),
    );
    return _sharedPref.getBool(isLoggedInString) ?? false;
  }
}
