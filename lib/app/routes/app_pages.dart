import 'package:flutter/material.dart';
import 'package:keyboard/app/modules/keyboard_keyboard/keyboard_layout.dart';
import 'package:keyboard/app/modules/settings/language_page.dart';
import 'package:keyboard/app/modules/settings/settings_page.dart';
import 'package:keyboard/app/modules/settings/voice_and_subtitle_page.dart';
import 'package:keyboard/app/modules/splash/splash_screen.dart';
import 'package:keyboard/app/routes/app_routes.dart';
import 'package:keyboard/app/modules/login/temporary_login.dart';

class AppPages {
  static final Map<String, Widget Function(BuildContext)> pages = {
    AppRoutes.SPLASH: (context) => const SplashScreen(),
    AppRoutes.LOGIN: (context) => const TemporaryLogin(),
    AppRoutes.KEYBOARD: (context) => const KeyboardLayoutScreen(),
    AppRoutes.SETTINGS: (context) => const SettingsPage(),
    AppRoutes.SETTINGS_LANG: (context) => const LanguagePage(),
    AppRoutes.SETTINGS_VOICE: (context) => const VoiceAndSubtitlesPage(),
  };
}
