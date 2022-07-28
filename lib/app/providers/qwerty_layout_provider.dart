import 'dart:convert';

import 'package:keyboards/app/data/models/predict_response_model.dart';
import 'package:keyboards/app/utils/http_client.dart';
import 'package:flutter/material.dart';

class QwertyLayoutProvider extends ChangeNotifier {
  final TextEditingController qwertyController = TextEditingController();
  String selectedString = '';
  final HttpClient httpClient = HttpClient();
  late PredictResponse mainResponse;
  late PredictResponse cacheResponse;
  List<String> hintsValues = ['', '', ''];
  List<String> predictions = [];

  Future<void> predictNextValue(String value) async {
    qwertyController.text = qwertyController.text + value;
    notifyListeners();
  }

  Future<void> receivePredictedWords() async {
    final map = {
      'sentence': qwertyController.text,
      'userName': 'user',
      'model': 'test',
      'language': 'es',
    };
    // var data = jsonEncode(map);
    // print(data);
    final response = await httpClient.postPredict(
      data: map,
      url:
          'https://us-central1-questions-abd23.cloudfunctions.net/viterbi/predict',
    );
    final data = jsonDecode(response);
    print(data);
    final cacheSource = jsonEncode(data[0]);
    final mainSource = jsonEncode(data[1]);
    final mainDecoded = jsonDecode(mainSource);
    final cacheDecoded = jsonDecode(cacheSource);
    mainResponse = PredictResponse.fromJson(mainDecoded);
    cacheResponse = PredictResponse.fromJson(cacheDecoded);
  }

  Future<void> addSpace() async {
    qwertyController.text = qwertyController.text + ' ';
    await receivePredictedWords();
    notifyListeners();
    await showPredictions();
  }

  Future<void> showPredictions() async {
    ///creating a list to add all of the predictions
    predictions = [];
    if (cacheResponse.results!.isEmpty) {
      print('result is empty');
    } else {
      print('we have something');
      cacheResponse.results!.forEach((element) {
        predictions.add(element!.name!);
      });
      int i = 0;
      for (var el in hintsValues) {
        if (predictions.length < i) {
          hintsValues[i] = '';
        }
        hintsValues[i] = predictions[i];
        i++;
      }
    }
    if (mainResponse.results!.isEmpty) {
      print('empty data');
    } else {
      print('we got it');
      if (cacheResponse.results!.isEmpty) {
        predictions = [];
      }
      mainResponse.results!.forEach((element) {
        predictions.add(element!.name!);
      });
      int i = 0;
      for (var el in hintsValues) {
        hintsValues[i] = predictions[i];
        i++;
      }
    }
    notifyListeners();
  }

  void deleteLastCharacter() {
    if (qwertyController.text.isEmpty) {
    } else if (qwertyController.text.length == 1) {
      qwertyController.text = '';
      selectedString = '';
    } else {
      qwertyController.text =
          qwertyController.text.substring(0, qwertyController.text.length - 1);
    }
    print(qwertyController.text);
    notifyListeners();
  }

  Future<void> deleteWholeSentence() async {
    await sendSentenceForLearning();
    qwertyController.text = '';
    selectedString = '';
    hintsValues = ['', '', ''];
    notifyListeners();
  }

  Future<void> speakSentenceAndSendItToLearn() async {
    //todo: add here the feature to speak

    await deleteWholeSentence();
  }

  Future<void> sendSentenceForLearning() async {
    final ans = await httpClient.post(
      /// change values after testing
      data: {
        "sentence": qwertyController.text,
        "userName": "user",
        "model": "test",
        "language": "es"
      },
      url:
          'https://us-central1-questions-abd23.cloudfunctions.net/viterbi/learn',
    );
    print(ans.toString());
  }
}
