import 'package:flutter/material.dart';
import 'package:keyboard/application/common/constants.dart';
import 'package:keyboard/application/providers/tts_controller.dart';
import 'package:keyboard/core/abstracts/local_database.dart';
import 'package:keyboard/core/enums/keyboard_layouts.dart';
import 'package:collection/collection.dart';

typedef LanguageType = Map<String, dynamic>;

class SettingsProvider extends ChangeNotifier {
  final TTSController _ttsController;

  late double buttonActionsSize = localDatabase.user?.fontSize ?? 0.5;
  LanguageType get currentLanguage =>
      kLanguages.firstWhereOrNull(
        (element) => element['code'] == localDatabase.user?.language.split('-')[0],
      ) ??
      kLanguages.first;

  KeyboardLayout get keyboardLayout => localDatabase.user?.keyboardLayout ?? KeyboardLayout.qwerty;
  final Map<double, String> buttonActionsSizes = {0: 'Pequeño', 0.5: 'Mediano', 1: 'Grande'};

  TTSController get ttsController => _ttsController;
  final LocalDatabase localDatabase;

  SettingsProvider(this._ttsController, this.localDatabase);

  void changeLanguage({required String newValue}) {
    ttsController.languaje = newValue;
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
    // _ttsController.enabledTTS = _ttsController.availableTTS.where((element) => element.startsWith(clientLanguage)).toList();
    _ttsController.languaje = _ttsController.enabledTTS.first;
    _ttsController.enabledTTS.sort();
    _ttsController.notifyListeners();
    notifyListeners();
  }

  Future<void> updateKeyboardLayout(KeyboardLayout value) async {
    final newUser = localDatabase.user!.copyWith(keyboardLayout: value);

    await localDatabase.setUser(newUser);
    notifyListeners();
  }
}
