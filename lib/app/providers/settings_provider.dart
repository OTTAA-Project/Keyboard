import 'package:flutter/material.dart';
import 'package:keyboard/app/global_controllers/tts_controller.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  late TTSController _ttsController;
  late String language;
  late String keyboardLayout = 'QWERTY';
  late SharedPreferences _sharedPref;
  late String clientLanguage = 'es';
  late double buttonActionsSize = .5;
  String get languageName => kLanguages.firstWhere((element) => element['code'] == clientLanguage)['name'] ?? 'Español';
  final Map<double, String> buttonActionsSizes = {0: 'Pequeño', 0.5: 'Mediano', 1: 'Grande'};

  TTSController get ttsController => _ttsController;

  // final _authController = Get.find<AuthController>();
  // AuthController get authController => this._authController;

  SettingsProvider({BuildContext? context}) {
    _inIt(context: context!);
  }

  void _inIt({BuildContext? context}) async {
    _sharedPref = await SharedPreferences.getInstance();
    _ttsController = context!.read<TTSController>();
    language = _ttsController.languaje;

    if (!_sharedPref.containsKey('language')) {
      await _sharedPref.setString('language', 'es');
    }

    clientLanguage = _sharedPref.getString('language') ?? 'es';

    final String? layoutShared = _sharedPref.getString('keyboardLayout');
    if (layoutShared == null) {
      await _sharedPref.setString('keyboardLayout', 'QWERTY');
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

  void changeCurrentButtonActionsSize(double index) {
    print(index);
    buttonActionsSize = index;
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
