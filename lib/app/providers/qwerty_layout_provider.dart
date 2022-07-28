import 'package:keyboards/app/utils/http_client.dart';
import 'package:flutter/material.dart';

class QwertyLayoutProvider extends ChangeNotifier {
  final TextEditingController qwertyController = TextEditingController();
  String selectedString = '';
  final HttpClient httpClient = HttpClient();

  Future<void> predictNextValue(String value) async {
    qwertyController.text = qwertyController.text + value;
    notifyListeners();
  }

  Future<void> receivePredictedWords() async {
    final map = {
      'sentence': 'yo quiero ir a',
      'userName': 'asim',
      'model': 'test',
      'language': 'es',
    };
    // var data = jsonEncode(map);
    // print(data);
    final ans = await httpClient.post(
      /// change values after testing
      data: map,
      url:
          'https://us-central1-questions-abd23.cloudfunctions.net/viterbi/predict',
    );
    print(ans.toString());
  }

  Future<void> addSpace() async {
    qwertyController.text = qwertyController.text + ' ';
    print(qwertyController.text);
    await receivePredictedWords();
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
    notifyListeners();
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
