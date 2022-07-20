import 'package:http/http.dart' as http;

class HttpClient {
  Future<dynamic> post({required Map<String, String> data,required String url}) async {
    var uri = Uri.parse(
        url);
    var response = await http.post(
      uri,
      body: data,
    );
    return response.body;
  }
}
