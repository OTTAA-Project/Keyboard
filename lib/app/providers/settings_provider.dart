import 'package:flutter/material.dart';
import 'package:keyboards/app/global_controllers/tts_controller.dart';
import 'package:provider/provider.dart';

class SettingsProvider extends ChangeNotifier {
  late TTSController _ttsController;
  late String language;

  TTSController get ttsController => _ttsController;

  // final _authController = Get.find<AuthController>();
  // AuthController get authController => this._authController;
  bool isEnglish = false;

  SettingsProvider({BuildContext? context}) {
    _inIt(context: context!);
  }

  void _inIt({BuildContext? context}) async {
    _ttsController = context!.read<TTSController>();
    language = _ttsController.languaje;
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

  toggleLanguaje(bool value) {
    if (value == false) {
      _ttsController.languaje = "es";
      _ttsController.isEnglish = value;
    } else {
      _ttsController.languaje = "en";
      _ttsController.isEnglish = value;
    }
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
}
