import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:keyboard/app/utils/constants.dart';

class SharedPreferencesController extends ChangeNotifier {
  late SharedPreferences _instance;

  SharedPreferencesController() {
    _inIt();
  }

  Future<void> _inIt() async {
    _instance = await SharedPreferences.getInstance();
  }

  Future<bool> isLoggedIn()async{
    return _instance.getBool(isLoggedInString) ?? false;
  }
}
