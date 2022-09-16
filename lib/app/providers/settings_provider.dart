import 'package:flutter/material.dart';
import 'package:keyboard/app/global_controllers/tts_controller.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  late TTSController _ttsController;
  late String language;
  late String clientLanguage;

  String get languageName => kLanguages.firstWhere((element) => element['code'] == clientLanguage)['name'] ?? 'Español';

  TTSController get ttsController => _ttsController;

  // final _authController = Get.find<AuthController>();
  // AuthController get authController => this._authController;

  SettingsProvider({BuildContext? context}) {
    _inIt(context: context!);
  }

  void _inIt({BuildContext? context}) async {
    final shared = await SharedPreferences.getInstance();
    _ttsController = context!.read<TTSController>();
    language = _ttsController.languaje;

    if (!shared.containsKey('language')) {
      await shared.setString('language', 'es');
    }

    clientLanguage = shared.getString('language') ?? 'es';

    // final res = _ttsController.availableTTS.contains(language);
    // if (res) {
    // } else {
    //   language = _ttsController.availableTTS.first;
    // }
  }

  void changeLanguage({required String newValue}) {
    ttsController.languaje = newValue;
    language = newValue;
    notifyListeners();
  }

  toggleIsCustomTTSEnable(bool value) {
    _ttsController.isCustomTTSEnable = value;
    // update();
    notifyListeners();
  }

  toggleIsCustomSubtitle(bool value) {
    _ttsController.isCustomSubtitle = value;
    // update();
    notifyListeners();
  }

  toggleIsSubtitleUppercase(bool value) {
    _ttsController.isSubtitleUppercase = value;
    // update();
    notifyListeners();
  }

  setPitch(value) {
    _ttsController.pitch = value;
    // update();
    notifyListeners();
  }

  setRate(value) {
    _ttsController.rate = value;
    // update();
    notifyListeners();
  }

  setSubtitleSize(value) {
    _ttsController.subtitleSize = value;
    // update();
    notifyListeners();
  }

  void changeClientLanguage(String? value) async {
    clientLanguage = value ?? 'es';
    await SharedPreferences.getInstance().then((value) => value.setString('language', clientLanguage));
    _ttsController.enabledTTS = _ttsController.availableTTS.where((element) => element.startsWith(clientLanguage)).toList();
    _ttsController.languaje = _ttsController.enabledTTS.first;
    language = _ttsController.enabledTTS.first;
    _ttsController.enabledTTS.sort();
    _ttsController.notifyListeners();
    notifyListeners();
  }
}
