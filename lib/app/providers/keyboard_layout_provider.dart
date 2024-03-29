import 'dart:convert';
import 'package:emojis/emoji.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keyboard/app/data/enums/keyboard_layout.dart';
import 'package:keyboard/app/data/models/model_type_model.dart';
import 'package:keyboard/app/data/models/predict_response_model.dart';
import 'package:keyboard/app/global_controllers/tts_controller.dart';
import 'package:keyboard/app/utils/constants.dart';
import 'package:keyboard/app/utils/http_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyboardLayoutProvider extends ChangeNotifier {
  final TextEditingController qwertyController = TextEditingController();
  String selectedString = '';
  bool isMuted = false;
  final HttpClient httpClient = HttpClient();
  PredictResponse? predictionResponse;
  List<Result?> hintsValues = [];
  List<Result> predictions = [];
  late ModelTypeModel modelTypeModel;
  String modelType = '';
  bool isModelTypeDataLoaded = false;
  int predictionsPage = 0;
  int maxPredictionsPage = 0;
  late TTSController ttsController;
  late final SharedPreferences shared;

  KeyboardLayout currentLayout = KeyboardLayout.qwerty;

  final auth = FirebaseAuth.instance;

  bool isSpeaking = false;

  KeyboardLayoutProvider({required BuildContext context}) {
    inIt(context: context);
  }

  void inIt({required BuildContext context}) async {
    ttsController = context.read<TTSController>();
    shared = await SharedPreferences.getInstance();
    await getTheModelsList();
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

  void onChangeKeyboardLayout(KeyboardLayout layout) {
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
    final uid = auth.currentUser!.uid;
    final sentence = text;
    final model = modelType == "" ? "test" : modelType;
    final lng = shared.getString('language') ?? 'es';
    // var data = jsonEncode(map);
    // debugPrint(data);
    final response = await httpClient.postPredict(
      data: {
        "sentence": sentence,
        "uid": uid,
        "model": model,
        "language": lng,
      },
      url: '$kServerUrl/predict',
    );

    Map<String, dynamic> data = jsonDecode(response);

    if (data.containsKey('data')) {
      predictionResponse = PredictResponse(data: data['data'].map<Result>((e) => Result.fromJson(e)).toList());
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
    final uid = auth.currentUser!.uid;
    final sentence = qwertyController.text;
    final model = modelType == "" ? "test" : modelType;
    final lng = shared.getString('language') ?? 'es';

    if (sentence.trim().isEmpty) return;

    final ans = await httpClient.post(
      /// change values after testing
      data: {
        "sentence": sentence,
        "uid": uid,
        "model": model,
        "language": lng,
      },
      url: '$kServerUrl/users/learn',
    );
    debugPrint(ans.toString());
  }

  Future<void> getTheModelsList() async {
    final uid = auth.currentUser!.uid;
    final currentLng = shared.getString('language') ?? 'es';
    //TODO: Current language is hardcoded && uid is hardcoded
    final response = await httpClient.getRequest(
      url: '$kServerUrl/users/models?uid=$uid&language=$currentLng',
    );

    Map<String, dynamic> json = jsonDecode(response);

    if (json.containsKey("error")) {
      return;
    }

    ModelTypeModel models = ModelTypeModel(name: currentLng, value: List<String>.of((json["models"] as List<dynamic>).map((e) => e as String)));

    modelTypeModel = models;
    modelType = modelTypeModel.value[0];
    isModelTypeDataLoaded = true;

    debugPrint(modelTypeModel.value.toString());
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
