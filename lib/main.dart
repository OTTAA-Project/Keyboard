import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keyboard/application/application.dart';
import 'package:keyboard/application/injector.dart';
import 'package:keyboard/application/locator.dart';
import 'package:keyboard/firebase_options.dart';

void main() async {
  await Future.delayed(const Duration(milliseconds: 1000));
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "dotenv");

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }

  await setup();

  runApp(
    const Injector(
      application: Application(),
    ),
  );
}
