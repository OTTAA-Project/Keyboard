import 'package:flutter/material.dart';
import 'package:keyboard/app/global_controllers/tts_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  late TTSController _ttsController;
  late String language;
  late String keyboardLayout;
  late SharedPreferences _sharedPref;

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
    _sharedPref = await SharedPreferences.getInstance();
    final String? layoutShared = _sharedPref.getString('keyboardLayout');
    if (layoutShared == null) {
      await _sharedPref.setString('keyboardLayout', 'Qwerty');
    }

    keyboardLayout = _sharedPref.getString('keyboardLayout')!;
    notifyListeners();
  }

  void updateKeyboardLayout(String? layout) async {
    keyboardLayout = layout!;
    await _sharedPref.setString('keyboardLayout', layout);
    notifyListeners();
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
