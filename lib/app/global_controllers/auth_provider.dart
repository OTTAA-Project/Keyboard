import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  AuthProvider() {
    _inIt();
  }

  Future<auth.UserCredential> signInWithGoogle() async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final name = googleUser.displayName!;
    debugPrint('name from the google auth');
    debugPrint(name);
    final auth.OAuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredentials = await _firebaseAuth.signInWithCredential(credential);
    if (userCredentials.user != null) {
      debugPrint(userCredentials.user.toString());
      debugPrint(userCredentials.user!.email);
    }
    debugPrint('name from the firebae auth');
    debugPrint(userCredentials.user!.displayName);

    notifyListeners();

    return userCredentials;
  }

  Future<void> logout() async {
    final sharedPrefClient = await SharedPreferences.getInstance();
    sharedPrefClient.setBool(isLoggedInString, false);
    Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  void _inIt() async {}
}
