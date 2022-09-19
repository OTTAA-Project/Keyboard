import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keyboard/app/global_controllers/auth_provider.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:keyboard/app/utils/http_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final HttpClient httpClient = HttpClient();

  late AuthProvider _authProvider;
  bool signIn = false;

  // LoginProvider() {
  //   _inIt();
  // }
  //
  // void _inIt() async {
  //   await trySignIn();
  // }
  LoginProvider({required BuildContext context}) {
    _inIt(context: context);
  }

  void _inIt({required BuildContext context}) async {
    _authProvider = context.read<AuthProvider>();
  }

  Future<void> trySignIn() async {
    final SharedPreferences _sharedPref = await SharedPreferences.getInstance();
    try {
      final userCredentials = await _authProvider.signInWithGoogle();
      // if ok firebase will return a user else will throw an exception
      // final User? auth = FirebaseAuth.instance.currentUser;
      // final ref = databaseRef.child('Usuarios/${auth!.uid}/');
      // final res = await ref.get();
      // if (res.exists) {
      //   final instance = await SharedPreferences.getInstance();
      //   instance.setBool('First_time', true);
      //   instance.setBool('Avatar_photo', true);
      //   Get.offAllNamed(AppRoutes.HOME);
      // } else {
      //   // Get.offAllNamed(AppRoutes.ONBOARDING);
      // }
      if (userCredentials.user != null) {
        const uid = '0001'; //userCredentials.user!.uid;
        final response = await httpClient.post(url: '$kServerUrl/users', data: {"uid": uid});

        Map<String, dynamic> json = jsonDecode(response);

        if (json.containsKey('error') && json['error'] != 'UID already exists!') {
          debugPrint(json['error']);
          await _authProvider.logout();
          signIn = false;
          return;
        }

        signIn = true;
        _sharedPref.setBool(isLoggedInString, true);
        _sharedPref.setString("language", "es");
        _sharedPref.setString('keyboardLayout', 'Qwerty');
        debugPrint('yes');
      }
    } catch (e) {
      debugPrint(e.toString());
      signIn = false;
      debugPrint('no');
    }
  }
}
