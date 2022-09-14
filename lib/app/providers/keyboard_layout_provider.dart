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
  late PredictResponse mainResponse;
  late PredictResponse cacheResponse;
  List<Result?> hintsValues = [];
  List<Result> predictions = [];
  late ModelTypeModel modelTypeModel;
  String modelType = '';
  bool isModelTypeDataLoaded = false;
  int hintsCounter = 0;
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
    modelType = value;
    notifyListeners();
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
    final sentence = qwertyController.text;
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

    final mainDecoded = data['main'];
    final cacheDecoded = data['cache'];

    mainResponse = PredictResponse(source: 'main', results: mainDecoded.map<Result>((e) => Result.fromJson(e)).toList());
    cacheResponse = PredictResponse(source: 'cache', results: cacheDecoded.map<Result>((e) => Result.fromJson(e)).toList());
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

  List<Result> distinct(List<Result> i) {
    return i.toSet().toList(growable: true);
  }

  Future<void> showPredictions() async {
    ///creating a list to add all of the predictions
    hintsCounter = 0;
    predictions.clear();
    hintsValues.clear();

    if (cacheResponse.results!.isEmpty) {
      debugPrint('there is not any cache response');
    } else {
      debugPrint('Cache response is not empty');
      predictions.addAll(cacheResponse.results!.map((e) => e!).toList());
    }

    if (mainResponse.results!.isEmpty) {
      debugPrint('there is not any main response');
    } else {
      debugPrint('Main response is not empty');
      predictions.addAll(mainResponse.results!.map((e) => e!).toList());
    }
    debugPrint('length is ${predictions.length}');
    // final pre = distinct(predictions);
    // predictions.clear();
    // predictions = pre;
    // final ids = Set();
    // predictions.retainWhere((x) => ids.add(x));
    // debugPrint(predictions.toSet().toList().length);
    debugPrint(predictions.toList().toString());
    debugPrint('length is ${predictions.length}');

    predictions = distinct(predictions);

    hintsCounter++;
    notifyListeners();

    final cache = cacheResponse.results!.toList();
    final main = mainResponse.results!.where((mainPredict) => !cache.any((cachePredict) => cachePredict!.name == mainPredict!.name!)).toList();

    int lastCache = 0;
    int lastMain = 0;

    for (var i = 0; i < 4; i++) {
      try {
        if (i % 2 == 0) {
          hintsValues.add(cache[lastCache]);
          lastCache++;
        } else {
          hintsValues.add(main[lastMain]);
          lastMain++;
        }
      } catch (e) {
        continue;
      }
    }
  }

  void updateHints() {
    if (predictions.length == hintsCounter * 4) {
      return;
    }
    if (predictions.length > hintsCounter * 4) {
      // if (predictions.length % (hintsCounter * 3) == 1) {
      //   hintsValues[0] = predictions[(hintsCounter * 3) + 1];
      //   hintsValues[1] = '';
      //   hintsValues[2] = '';
      // } else if (predictions.length - (hintsCounter * 3) == 2) {
      //   hintsValues[0] = predictions[(hintsCounter * 3) + 1];
      //   hintsValues[1] = predictions[(hintsCounter * 3) + 2];
      //   hintsValues[2] = '';
      // } else if (predictions.length - (hintsCounter * 3) == 3) {
      //   hintsValues[0] = predictions[(hintsCounter * 3) + 1];
      //   hintsValues[1] = predictions[(hintsCounter * 3) + 2];
      //   hintsValues[2] = predictions[(hintsCounter * 3) + 3];
      // }
      try {
        hintsValues[0] = predictions[(hintsCounter * 4)];
        if (predictions.length > (hintsCounter * 4) + 1) {
          hintsValues[1] = predictions[(hintsCounter * 4) + 1];
        } else {
          hintsValues.removeAt(1);
        }
        if (predictions.length > (hintsCounter * 4) + 2) {
          hintsValues[2] = predictions[(hintsCounter * 4) + 2];
        } else {
          hintsValues.removeAt(2);
        }
        if (predictions.length > (hintsCounter * 4) + 3) {
          hintsValues[3] = predictions[(hintsCounter * 4) + 3];
        } else {
          hintsValues.removeAt(3);
        }
      } catch (e) {
        debugPrintStack();
      }
    }
    hintsCounter++;
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
