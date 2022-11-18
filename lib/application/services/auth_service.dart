import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keyboard/core/abstracts/local_database.dart';
import 'package:keyboard/core/enums/keyboard_layouts.dart';
import 'package:keyboard/core/models/user_model.dart';
import 'package:keyboard/core/enums/sign_in_types.dart';
import 'package:keyboard/core/repository/auth_repository.dart';
import 'package:keyboard/core/repository/users_repository.dart';

class AuthService implements IAuthRepository {
  final FirebaseAuth _authProvider = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final LocalDatabase _localDatabase;
  final IUserRepository _userRepository;

  AuthService(this._localDatabase, this._userRepository);

  @override
  Future<UserModel?> getCurrentUser() async => _localDatabase.user;

  @override
  Future<bool> isLoggedIn() async {
    if (_localDatabase.user == null && _authProvider.currentUser != null) {
      final authUser = _authProvider.currentUser!;
      final loggedUser = UserModel(
        id: authUser.uid,
        name: authUser.displayName ?? "",
        email: authUser.email ?? "",
        photoUrl: authUser.photoURL ?? "",
        language: "es-AR",
        keyboardLayout: KeyboardLayout.qwerty,
        fontSize: 0.5
      );

      await _userRepository.saveUser(authUser.uid);
      await _localDatabase.setUser(loggedUser);

      return true;
    }

    return _localDatabase.user != null;
  }

  @override
  Future<void> logout() async {
    await _authProvider.signOut();
    await _localDatabase.deleteUser();
  }

  @override
  Future<UserModel?> signIn(SignInTypes signInType, {payload}) async {
    User? authUser;
    switch (signInType) {
      case SignInTypes.google:
        authUser = await _signInWithGoogle();
        break;
      default:
        return null;
    }

    if (authUser == null) return null;

    final loggedUser = UserModel(
      id: authUser.uid,
      name: authUser.displayName ?? "",
      email: authUser.email ?? "",
      photoUrl: authUser.photoURL ?? "",
      language: "es-AR",
      keyboardLayout: KeyboardLayout.qwerty,
      fontSize: 0.5
    );

    await _userRepository.saveUser(authUser.uid);

    await _localDatabase.setUser(loggedUser);

    return loggedUser;
  }

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _authProvider.signInWithCredential(credential);

      if (userCredential.user == null) {
        return null;
      }

      final User user = userCredential.user!;

      return user;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String> signUp({payload}) async {
    return "Sign Up method not implemented";
  }
}
