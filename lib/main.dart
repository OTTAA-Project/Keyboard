import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keyboard/app/global_controllers/auth_provider.dart';
import 'package:keyboard/app/global_controllers/shared_preferences_controller.dart';
import 'package:keyboard/app/global_controllers/tts_controller.dart';
import 'package:keyboard/app/modules/login/temporary_login.dart';
import 'package:keyboard/app/modules/qwetry_keyboard/qwerty_layout.dart';
import 'package:keyboard/app/modules/settings/language_page.dart';
import 'package:keyboard/app/modules/settings/settings_page.dart';
import 'package:keyboard/app/modules/settings/voice_and_subtitle_page.dart';
import 'package:keyboard/app/modules/splash/splash_screen.dart';
import 'package:keyboard/app/providers/login_provider.dart';
import 'package:keyboard/app/providers/qwerty_layout_provider.dart';
import 'package:keyboard/app/providers/settings_provider.dart';
import 'package:keyboard/app/providers/splash_provider.dart';
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
            messagingSenderId:
                dotenv.env['MESSAGING_SENDER_ID'] ?? 'add Proper Values',
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
            return AuthProvider();
          },
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) {
            return TTSController();
          },
          lazy: false,
        ),
        // ChangeNotifierProxyProvider<FlutterTTS, SettingsProvider>(
        //   update: (context, flutterTTS, settingsProvider) => settingsProvider(null),
        //   create: (BuildContext context) => SettingsProvider(null),
        // ),
        ChangeNotifierProvider(
          create: (_) {
            return SplashProvider();
          },
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) {
            return LoginProvider(context: context);
          },
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) {
            return QwertyLayoutProvider(context: context);
          },
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SettingsProvider(context: context);
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
          '/settings': (context) => const SettingsPage(),
          '/language': (context) => const LanguagePage(),
          '/voice_and_subtitles': (context) => const VoiceAndSubtitlesPage(),
        },
      ),
    );
  }
}
