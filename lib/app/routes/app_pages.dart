import 'package:flutter/material.dart';
import 'package:keyboards/app/modules/login/temporary_login.dart';
import 'package:keyboards/app/modules/qwetry_keyboard/qwerty_layout.dart';
import 'package:keyboards/app/modules/settings/language_page.dart';
import 'package:keyboards/app/modules/settings/settings_page.dart';
import 'package:keyboards/app/modules/settings/voice_and_subtitle_page.dart';
import 'package:keyboards/app/modules/splash/splash_screen.dart';
import 'package:keyboards/app/routes/app_routes.dart';

class AppPages {
  static final Map<String, Widget Function(BuildContext)> pages = {
    AppRoutes.SPLASH: (context) => const SplashScreen(),
    AppRoutes.LOGIN: (context) => const TemporaryLogin(),
    AppRoutes.QWERTYKEYBOARD: (context) => const QwertyLayout(),
    AppRoutes.SETTINGS: (context) => const SettingsPage(),
    AppRoutes.SETTINGS_LANG: (context) => const LanguagePage(),
    AppRoutes.SETTINGS_VOICE: (context) => const VoiceAndSubtitlesPage(),
  };
}
