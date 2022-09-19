import 'package:keyboard/app/global_controllers/auth_provider.dart';
import 'package:keyboard/app/global_controllers/shared_preferences_controller.dart';
import 'package:keyboard/app/global_controllers/tts_controller.dart';
import 'package:keyboard/app/providers/login_provider.dart';
import 'package:keyboard/app/providers/keyboard_layout_provider.dart';
import 'package:keyboard/app/providers/settings_provider.dart';
import 'package:keyboard/app/providers/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProvidersList {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) {
        return SharedPreferencesController();
      },
    ),
    ChangeNotifierProvider(
      create: (_) {
        return AuthProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (_) {
        return TTSController();
      },
    ),
    // ChangeNotifierProxyProvider<FlutterTTS, SettingsProvider>(
    //   update: (context, flutterTTS, settingsProvider) => settingsProvider(null),
    //   create: (BuildContext context) => SettingsProvider(null),
    // ),
    ChangeNotifierProvider(
      create: (_) {
        return SplashProvider();
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return LoginProvider(context: context);
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return KeyboardLayoutProvider(context: context);
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return SettingsProvider(context: context);
      },
    ),
  ];
}
