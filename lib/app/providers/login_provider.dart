import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  bool signIn = false;

  // LoginProvider() {
  //   _inIt();
  // }
  //
  // void _inIt() async {
  //   await trySignIn();
  // }

  Future<auth.UserCredential> signInWithGoogle() async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final name = googleUser.displayName!;
    debugPrint('name from the google auth');
    debugPrint(name);
    final auth.OAuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredentials =
        await _firebaseAuth.signInWithCredential(credential);
    if (userCredentials.user != null) {
      debugPrint(userCredentials.user.toString());
      debugPrint(userCredentials.user!.email);
    }
    debugPrint('name from the firebae auth');
    debugPrint(userCredentials.user!.displayName);
    return userCredentials;
  }

  Future<void> trySignIn() async {
    try {
      final userCredentials = await signInWithGoogle();
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
        print('yes');
      }
    } catch (e) {
      debugPrint(e.toString());
      signIn = false;
      print('no');
    }
  }
}