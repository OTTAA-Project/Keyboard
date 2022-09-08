import 'dart:convert';
import 'package:emojis/emoji.dart';
import 'package:keyboard/app/data/enums/keyboard_layout.dart';
import 'package:keyboard/app/data/models/model_type_model.dart';
import 'package:keyboard/app/data/models/predict_response_model.dart';
import 'package:keyboard/app/global_controllers/tts_controller.dart';
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
  List<String> hintsValues = ['', '', '', ''];
  List<String> predictions = [];
  late ModelTypeModel modelTypeModel;
  String modelType = '';
  bool isModelTypeDataLoaded = false;
  int hintsCounter = 0;
  late TTSController ttsController;

  KeyboardLayout currentLayout = KeyboardLayout.qwerty;

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
    print(ttsController.volume);
  }

  Future<void> predictNextValue(String value) async {
    qwertyController.text = qwertyController.text + value;
    notifyListeners();
  }

  Future<void> receivePredictedWords(String text) async {
    final map = {
      'sentence': text,
      'userName': 'user',
      'model': modelType == '' ? 'test' : modelType,
      'language': 'es',
    };
    // var data = jsonEncode(map);
    // debugPrint(data);
    final response = await httpClient.postPredict(
      data: map,
      url: 'https://us-central1-keyboard-98820.cloudfunctions.net/viterbi/predict',
    );
    debugPrint(response);
    final data = jsonDecode(response);
    debugPrint(data.toString());
    final cacheSource = jsonEncode(data[0]);
    final mainSource = jsonEncode(data[1]);
    final mainDecoded = jsonDecode(mainSource);
    final cacheDecoded = jsonDecode(cacheSource);
    mainResponse = PredictResponse.fromJson(mainDecoded);
    cacheResponse = PredictResponse.fromJson(cacheDecoded);
  }

  Future<void> addSpace() async {
    qwertyController.text = qwertyController.text + ' ';
    print(qwertyController.text);
    final searchTerm = qwertyController.text.replaceAll(emojiRegex, '');
    print(searchTerm);
    if (searchTerm.trim().isNotEmpty) {
      await receivePredictedWords(searchTerm);
      await showPredictions();
    }
    notifyListeners();
  }

  Iterable distinct(Iterable i) {
    var set = new Set();
    return i.where((e) {
      var isNew = !set.contains(e);
      set.add(e);
      return isNew;
    });
  }

  Future<void> showPredictions() async {
    ///creating a list to add all of the predictions
    hintsCounter = 0;
    predictions = [];
    hintsValues = ['', '', '', ''];
    if (cacheResponse.results!.isEmpty) {
      debugPrint('result is empty');
    } else {
      debugPrint('we have something');
      for (var element in cacheResponse.results!) {
        predictions.add(element!.name!);
      }
      // int i = 0;
      // for (var el in predictions) {
      //   if (predictions.length < i) {
      //     hintsValues[i] = '';
      //   }
      //   hintsValues[i] = predictions[i];
      //   i++;
      // }
    }
    if (mainResponse.results!.isEmpty) {
      debugPrint('empty data');
    } else {
      debugPrint('we got it');
      // if (cacheResponse.results!.isEmpty) {
      //   predictions = [];
      // }
      for (var element in mainResponse.results!) {
        predictions.add(element!.name!);
      }
      // int i = predictions.length;
      // for (var el in hintsValues) {
      //   hintsValues[i] = predictions[i];
      //   i++;
      // }
    }
    print('length is ${predictions.length}');
    final pre = distinct(predictions).toList() as List<String>;
    predictions.clear();
    predictions = pre;
    // final ids = Set();
    // predictions.retainWhere((x) => ids.add(x));
    // print(predictions.toSet().toList().length);
    print(predictions.toList());
    print('length is ${predictions.length}');
    int i = 0;
    int counter = 0;
    if (predictions.length >= 4) {
      counter = 4;
    } else {
      counter = predictions.length - 1;
    }
    while (i < counter) {
      hintsValues[i] = predictions[i];
      i++;
    }
    hintsCounter++;
    notifyListeners();
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
      hintsValues[0] = predictions[(hintsCounter * 4)];
      if (predictions.length > (hintsCounter * 4) + 1) {
        hintsValues[1] = predictions[(hintsCounter * 4) + 1];
      } else {
        hintsValues[1] = '';
      }
      if (predictions.length > (hintsCounter * 4) + 2) {
        hintsValues[2] = predictions[(hintsCounter * 4) + 2];
      } else {
        hintsValues[2] = '';
      }
      if (predictions.length > (hintsCounter * 4) + 3) {
        hintsValues[3] = predictions[(hintsCounter * 4) + 3];
      } else {
        hintsValues[3] = '';
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
      hintsValues = ['', '', '', ''];
    } else {
      qwertyController.text = qwertyController.text.substring(0, qwertyController.text.length - 1);
      hintsValues = ['', '', '', ''];
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
    await sendSentenceForLearning();
    qwertyController.text = '';
    selectedString = '';
    hintsValues = ['', '', '', ''];
    notifyListeners();
  }

  Future<void> speakSentenceAndSendItToLearn() async {
    ttsController.speak(qwertyController.text);
    await deleteWholeSentence();
  }

  Future<void> sendSentenceForLearning() async {
    final ans = await httpClient.post(
      /// change values after testing
      data: {"sentence": qwertyController.text, "userName": "user", "model": modelType == '' ? 'test' : modelType, "language": "es"},
      url: 'https://us-central1-keyboard-98820.cloudfunctions.net/viterbi/learn',
    );
    debugPrint(ans.toString());
  }

  Future<void> getTheModelsList() async {
    final response = await httpClient.getRequest(
      url: 'https://us-central1-keyboard-98820.cloudfunctions.net/viterbi/models?language=es',
    );
    final json = jsonDecode(response);
    modelTypeModel = ModelTypeModel.fromJson(json);
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