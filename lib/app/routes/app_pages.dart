import 'package:flutter/material.dart';
import 'package:keyboard/app/modules/keyboard/keyboard_layout.dart';
import 'package:keyboard/app/modules/settings/accessibility_page.dart';
import 'package:keyboard/app/modules/settings/keyboard_page.dart';
import 'package:keyboard/app/modules/settings/language_page.dart';
import 'package:keyboard/app/modules/settings/settings_page.dart';
import 'package:keyboard/app/modules/settings/voice_and_subtitle_page.dart';
import 'package:keyboard/app/modules/splash/splash_screen.dart';
import 'package:keyboard/app/routes/app_routes.dart';
import 'package:keyboard/app/modules/login/temporary_login.dart';

class AppPages {
  static final Map<String, Widget Function(BuildContext)> pages = {
    AppRoutes.splash: (context) => const SplashScreen(),
    AppRoutes.login: (context) => const TemporaryLogin(),
    AppRoutes.keyboard: (context) => const KeyboardLayoutScreen(),
    AppRoutes.settings: (context) => const SettingsPage(),
    AppRoutes.settingsLang: (context) => const LanguagePage(),
    AppRoutes.settingsVoice: (context) => const VoiceAndSubtitlesPage(),
    AppRoutes.settingsKeyboard: (context) => const KeyboardPage(),
    AppRoutes.settingsAccessibility: (context) => const AccessibilityPage(),
  };
}
