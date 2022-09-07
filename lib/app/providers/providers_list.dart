import 'package:keyboards/app/global_controllers/auth_provider.dart';
import 'package:keyboards/app/global_controllers/shared_preferences_controller.dart';
import 'package:keyboards/app/global_controllers/tts_controller.dart';
import 'package:keyboards/app/providers/login_provider.dart';
import 'package:keyboards/app/providers/keyboard_layout_provider.dart';
import 'package:keyboards/app/providers/settings_provider.dart';
import 'package:keyboards/app/providers/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProvidersList{
  static final List<SingleChildWidget> providers = [
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
        return KeyboardLayoutProvider(context: context);
      },
      lazy: true,
    ),
    ChangeNotifierProvider(
      create: (context) {
        return SettingsProvider(context: context);
      },
      lazy: true,
    ),
  ];
}