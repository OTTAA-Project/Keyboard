import 'package:keyboards/app/utils/http_client.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class QwertyLayoutProvider extends ChangeNotifier {
  final TextEditingController qwertyController = TextEditingController();
  String selectedString = '';
  final HttpClient httpClient = HttpClient();

  void predictNextValue(String value) {
    qwertyController.text = qwertyController.text + value;
    print(qwertyController.text);

    notifyListeners();
  }

  void addSpace() {
    qwertyController.text = qwertyController.text + ' ';
    print(qwertyController.text);
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

  Future<void> deleteWholeSentence() async{
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
