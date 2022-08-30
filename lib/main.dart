import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keyboards/app/global_controllers/shared_preferences_controller.dart';
import 'package:keyboards/app/global_controllers/tts_controller.dart';
import 'package:keyboards/app/modules/login/temporary_login.dart';
import 'package:keyboards/app/modules/qwetry_keyboard/qwerty_layout.dart';
import 'package:keyboards/app/modules/splash/splash_screen.dart';
import 'package:keyboards/app/providers/login_provider.dart';
import 'package:keyboards/app/providers/qwerty_layout_provider.dart';
import 'package:keyboards/app/providers/splash_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await Future.delayed(const Duration(milliseconds: 1000));
  await dotenv.load(fileName: "dotenv");
  WidgetsFlutterBinding.ensureInitialized();
  kIsWeb
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: dotenv.env['API_KEY'] ?? 'add Proper Values',
            appId: dotenv.env['APP_ID'] ?? 'add Proper Values',
            messagingSenderId: dotenv.env['MESSAGING_SENDER_ID'] ?? 'add Proper Values',
            projectId: dotenv.env['PROJECT_ID'] ?? 'add Proper Values',
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return SharedPreferencesController();
          },
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) {
            return FlutterTTS();
          },
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) {
            return SplashProvider();
          },
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) {
            return LoginProvider();
          },
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) {
            return QwertyLayoutProvider();
          },
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const TemporaryLogin(),
          '/qwerty_keyboard': (context) => const QwertyLayout(),
        },
      ),
    );
  }
}
