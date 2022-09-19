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

class KeyboardLayoutProvider extends ChangeNotifier {
  final TextEditingController qwertyController = TextEditingController();
  String selectedString = '';
  bool muteOrNot = false;
  final HttpClient httpClient = HttpClient();
  late PredictResponse predictionResponse;
  List<Result?> hintsValues = [];
  List<Result> predictions = [];
  late ModelTypeModel modelTypeModel;
  String modelType = '';
  bool isModelTypeDataLoaded = false;
  int predictionsPage = 0;
  int maxPredictionsPage = 0;
  late TTSController ttsController;

  KeyboardLayout currentLayout = KeyboardLayout.qwerty;

  final auth = FirebaseAuth.instance;

  bool isSpeaking = false;

  KeyboardLayoutProvider({required BuildContext context}) {
    inIt(context: context);
  }

  void inIt({required BuildContext context}) async {
    ttsController = context.read<TTSController>();
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
    muteOrNot = !muteOrNot;
    ttsController.setVolume = muteOrNot ? 0.8 : 0.0;
    notifyListeners();
    debugPrint(ttsController.volume.toString());
  }

  Future<void> predictNextValue(String value) async {
    qwertyController.text = qwertyController.text + value;
    notifyListeners();
  }

  Future<void> receivePredictedWords(String text) async {
    const uid = "0001";
    final sentence = text;
    final model = modelType == "" ? "test" : modelType;
    const lng = 'es';
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

    debugPrint(response);

    Map<String, dynamic> data = jsonDecode(response);

    debugPrint(data.toString());

    predictionResponse = PredictResponse(data: data['data'].map<Result>((e) => Result.fromJson(e)).toList());
  }

  Future<void> addSpace() async {
    qwertyController.text = qwertyController.text + ' ';
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
    predictionsPage = 0;
    predictions.clear();
    hintsValues.clear();

    if (predictionResponse.data!.isEmpty) {
      debugPrint('there is not any response');
    } else {
      debugPrint('Response is not empty');
      predictions.addAll(predictionResponse.data!.map((e) => e!).toList());
    }

    debugPrint('length is ${predictions.length}');
    predictions = buildPredictions(predictions);
    maxPredictionsPage = (predictions.length > 4) ? (predictions.length / 5).ceil().abs() : 0;
    debugPrint(predictions.toList().toString());
    debugPrint('length is ${predictions.length}');
    debugPrint('max predictions page is $maxPredictionsPage');

    notifyListeners();

    if (predictions.isNotEmpty) hintsValues.addAll(predictions.sublist(0, predictions.length.clamp(predictions.length < 4 ? predictions.length : 1, 4)));
  }

  void updateHints() {
    if (predictions.isEmpty) return;

    if (predictionsPage == maxPredictionsPage) {
      predictionsPage = 0;
    } else {
      predictionsPage++;
    }

    hintsValues.clear();

    for (var i = 0; i < 4; i++) {
      try {
        hintsValues.add(predictions[i + (predictionsPage * 4)]);
      } catch (e) {
        if (hintsValues.contains(predictions.last)) continue;
        hintsValues.add(predictions.last);
        continue;
      }
    }

    notifyListeners();
  }

  void deleteLastCharacter() async {
    if (qwertyController.text.trim().isEmpty) {
      // hintsValues = ['', '', '', ''];
    } else if (qwertyController.text.length == 1) {
      qwertyController.text = '';
      selectedString = '';
      hintsValues.clear();
    } else {
      qwertyController.text = qwertyController.text.substring(0, qwertyController.text.length - 1);
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
    const uid = "0001";
    final sentence = qwertyController.text;
    final model = modelType == "" ? "test" : modelType;
    const lng = 'es';

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
    const uid = "0001"; //auth.currentUser!.uid;
    const currentLng = "es";
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
    qwertyController.text = qwertyController.text + text;
    await addSpace();
    notifyListeners();
  }
}
