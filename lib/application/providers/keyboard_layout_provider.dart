import 'dart:convert';
import 'package:emojis/emoji.dart';
import 'package:keyboard/application/providers/tts_controller.dart';
import 'package:flutter/material.dart';
import 'package:keyboard/core/abstracts/local_database.dart';
import 'package:keyboard/core/dtos/models_get_dto.dart';
import 'package:keyboard/core/dtos/prediction_get_dto.dart';
import 'package:keyboard/core/enums/keyboard_layouts.dart';
import 'package:keyboard/core/models/data_models.dart';
import 'package:keyboard/core/models/model_type_model.dart';
import 'package:keyboard/core/models/predict_response_model.dart';
import 'package:keyboard/core/models/user_model.dart';
import 'package:keyboard/core/repository/prediction_repository.dart';
import 'package:keyboard/core/repository/users_repository.dart';

class KeyboardLayoutProvider extends ChangeNotifier {
  final TextEditingController qwertyController = TextEditingController();
  String selectedString = '';
  bool isMuted = false;

  PredictResponse? predictionResponse;
  List<Result?> hintsValues = [];
  List<Result> predictions = [];
  late DataModels modelTypeModel;
  String modelType = '';
  bool isModelTypeDataLoaded = false;
  int predictionsPage = 0;
  int maxPredictionsPage = 0;

  KeyboardTypes currentLayout = KeyboardTypes.qwerty;

  bool isSpeaking = false;

  final TTSController ttsController;
  final IUserRepository userRepository;
  final IPredictionRepository predictionRepository;
  final LocalDatabase localDatabase;

  KeyboardLayoutProvider({
    required this.ttsController,
    required this.predictionRepository,
    required this.userRepository,
    required this.localDatabase,
  }) {
    getTheModelsList();
  }

  void onChangedDropDownMenu({required String value}) {
    if (value != modelType) {
      modelType = value;
      hintsValues.clear();
      predictions.clear();
      receivePredictedWords(qwertyController.text).then((value) => showPredictions());
      notifyListeners();
    }
  }

  void onChangeKeyboardLayout(KeyboardTypes layout) {
    currentLayout = layout;
    notifyListeners();
  }

  void muteFunction() {
    isMuted = !isMuted;
    ttsController.setVolume = isMuted ? 0.0 : 0.8;
    notifyListeners();
    debugPrint(ttsController.volume.toString());
  }

  Future<void> predictNextValue(String value) async {
    qwertyController.text = qwertyController.text + value;
    notifyListeners();
  }

  Future<void> receivePredictedWords(String text) async {
    debugPrint('text: $text');
    final UserModel user = localDatabase.user!;
    final sentence = text;
    final model = modelType == "" ? "test" : modelType;
    final lng = user.language.split("-")[0];
    // var data = jsonEncode(map);
    // debugPrint(data);

    final PredictionGetDto response = await predictionRepository.getPrediction(user.id, lng, sentence, model);
    if (response.status == 200 && response.data != null) {
      predictionResponse = response.data;
    }
    notifyListeners();
  }

  Future<void> addSpace() async {
    qwertyController.text = '${qwertyController.text} ';
    debugPrint(qwertyController.text);
    final searchTerm = qwertyController.text.replaceAll(emojiRegex, '');
    debugPrint(searchTerm);
    if (searchTerm.trim().isNotEmpty) {
      await receivePredictedWords(searchTerm);
      await showPredictions();
    }
    notifyListeners();
  }

  List<Result> buildPredictions(List<Result> i) {
    return i.toSet().toList(growable: true)..sort((a, b) => a.isCached ? 0 : b.value!.compareTo(a.value!));
  }

  Future<void> showPredictions() async {
    if (predictionResponse == null) {
      return;
    }

    predictionsPage = 0;
    predictions.clear();
    hintsValues.clear();

    if (predictionResponse!.data!.isEmpty) {
      debugPrint('there is not any response');
    } else {
      debugPrint('Response is not empty');
      predictions.addAll(predictionResponse!.data!.map((e) => e!).toList());
    }

    debugPrint('length is ${predictions.length}');
    predictions = buildPredictions(predictions);
    maxPredictionsPage = (predictions.length > 4) ? (predictions.length / 4).floor().abs() : 0;
    debugPrint(predictions.toList().toString());
    debugPrint('length is ${predictions.length}');
    debugPrint('max predictions page is $maxPredictionsPage');

    if (predictions.isNotEmpty) hintsValues.addAll(predictions.sublist(0, predictions.length.clamp(predictions.length < 4 ? predictions.length : 1, 4)));
    notifyListeners();
  }

  void updateHints() async {
    if (predictions.isEmpty) {
      final keyboardText = qwertyController.text;
      final last = keyboardText.substring(keyboardText.length - 1);

      await receivePredictedWords(qwertyController.text.replaceFirst(last, ''));
      await showPredictions();
      return;
    }

    if (predictionsPage == maxPredictionsPage) {
      predictionsPage = 0;
    } else {
      predictionsPage++;
    }

    if (maxPredictionsPage == 0) {
      return;
    }

    int index = (predictionsPage * 4);
    if (index > predictions.length) {
      index = predictions.length;
    }

    int endIndex = (index + 4);

    if (endIndex > predictions.length) {
      endIndex = predictions.length;
    }

    hintsValues.clear();
    hintsValues.addAll(predictions.sublist(index, endIndex));

    notifyListeners();
  }

  void deleteLastCharacter() async {
    if (qwertyController.text.trim().isEmpty) {
      selectedString = '';
      predictions.clear();
      hintsValues.clear();
    } else if (qwertyController.text.length == 1) {
      qwertyController.text = '';
      selectedString = '';
      predictions.clear();
      hintsValues.clear();
    } else {
      qwertyController.text = qwertyController.text.substring(0, qwertyController.text.length - 1);
      predictions.clear();
      hintsValues.clear();
    }

    final char = qwertyController.text.characters;

    final searchTerm = qwertyController.text.replaceAll(emojiRegex, '');

    if (searchTerm.length >= 2 && char.last == ' ') {
      selectedString = '';
      await receivePredictedWords(searchTerm);
      notifyListeners();
      await showPredictions();
    }
    debugPrint(qwertyController.text);
    notifyListeners();
  }

  Future<void> deleteWholeSentence() async {
    qwertyController.text = '';
    selectedString = '';
    hintsValues.clear();
    notifyListeners();
  }

  Future<void> speakSentenceAndSendItToLearn() async {
    isSpeaking = true;
    notifyListeners();
    await sendSentenceForLearning();
    await ttsController.speak(qwertyController.text);
    isSpeaking = false;
    await deleteWholeSentence();
  }

  Future<void> sendSentenceForLearning() async {
    final UserModel user = localDatabase.user!;

    final uid = user.id;
    final sentence = qwertyController.text;
    final model = modelType == "" ? "test" : modelType;
    final lng = user.language.split("-")[0];

    if (sentence.trim().isEmpty) return;

    await userRepository.learnText(uid, lng, sentence, model);
  }

  Future<void> getTheModelsList() async {
    final UserModel user = localDatabase.user!;

    final ModelsGetDto response = await userRepository.getModels(user.id, user.language.split('-')[0]);

    if (response.status != 200 && response.data == null) return;

    modelTypeModel = response.data!;
    modelType = response.data!.models[0];
    isModelTypeDataLoaded = true;

    notifyListeners();
  }

  void addHintToSentence({required String text}) async {
    final keyboardText = qwertyController.text;

    if (keyboardText.endsWith(' ') && keyboardText.trim().isNotEmpty) {
      qwertyController.text = '$keyboardText$text';
    } else if (keyboardText.trim().isNotEmpty) {
      final lastWord = keyboardText.split(' ').last;
      qwertyController.text = keyboardText.replaceFirst(lastWord, text);
    } else {
      qwertyController.text = '$keyboardText$text';
    }

    await addSpace();
    notifyListeners();
  }
}
