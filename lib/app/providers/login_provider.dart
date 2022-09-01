import 'package:flutter/material.dart';
import 'package:keyboards/app/global_controllers/auth_provider.dart';
import 'package:keyboards/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
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
        signIn = true;
        _sharedPref.setBool(isLoggedInString, true);
        debugPrint('yes');
      }
    } catch (e) {
      debugPrint(e.toString());
      signIn = false;
      debugPrint('no');
    }
  }
}
