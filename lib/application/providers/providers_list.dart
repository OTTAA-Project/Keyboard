import 'package:get_it/get_it.dart';
import 'package:keyboard/application/providers/tts_controller.dart';
import 'package:keyboard/application/providers/auth_provider.dart';
import 'package:keyboard/application/providers/keyboard_layout_provider.dart';
import 'package:keyboard/application/providers/settings_provider.dart';
import 'package:keyboard/application/providers/splash_provider.dart';
import 'package:keyboard/core/abstracts/local_database.dart';
import 'package:keyboard/core/repository/auth_repository.dart';
import 'package:keyboard/core/repository/prediction_repository.dart';
import 'package:keyboard/core/repository/users_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProvidersList {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) {
        return TTSController(GetIt.I<LocalDatabase>());
      },
    ),
    ChangeNotifierProvider(
      create: (_) {
        return SplashProvider(GetIt.I<IAuthRepository>());
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return AuthProvider(GetIt.I<IAuthRepository>());
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return KeyboardLayoutProvider(
          ttsController: context.read<TTSController>(),
          predictionRepository: GetIt.I<IPredictionRepository>(),
          userRepository: GetIt.I<IUserRepository>(),
          localDatabase: GetIt.I<LocalDatabase>(),
        );
      },
    ),
    ChangeNotifierProvider(
      create: (context) {
        return SettingsProvider(
          context.read<TTSController>(),
          GetIt.I<LocalDatabase>(),
        );
      },
    ),
  ];
}
