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
  List<String> hintsValues = ['', '', '', ''];
  List<String> predictions = [];
  late ModelTypeModel modelTypeModel;
  String modelType = '';
  bool isModelTypeDataLoaded = false;
  int hintsCounter = 0;
  late TTSController ttsController;

  KeyboardLayout currentLayout = KeyboardLayout.qwerty;

  final auth = FirebaseAuth.instance;

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
    List<dynamic> data = jsonDecode(response);

    debugPrint(data.toString());

    final mainDecoded = data[0];
    final cacheDecoded = data[1];

    mainResponse = PredictResponse.fromJson(mainDecoded);
    cacheResponse = PredictResponse.fromJson(cacheDecoded);
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

  Iterable distinct(Iterable i) {
    var set = <dynamic>{};
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
    debugPrint('length is ${predictions.length}');
    final pre = distinct(predictions).toList() as List<String>;
    predictions.clear();
    predictions = pre;
    // final ids = Set();
    // predictions.retainWhere((x) => ids.add(x));
    // debugPrint(predictions.toSet().toList().length);
    debugPrint(predictions.toList().toString());
    debugPrint('length is ${predictions.length}');
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

    if (!json.containsKey("data")) {
      return;
    }

    List<ModelTypeModel> models = json['data'].map<ModelTypeModel>((json) => ModelTypeModel.fromJson(json)).toList();

    modelTypeModel = models[0];
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
