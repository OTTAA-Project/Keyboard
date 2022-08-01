import 'package:http/http.dart' as http;

class HttpClient {
  Future<dynamic> post({required dynamic data, required String url}) async {
    var uri = Uri.parse(url);
    var response = await http.post(
      uri,
      body: data,
    );
    return response.body;
  }
  Future<String> postPredict({required dynamic data, required String url}) async {
    var uri = Uri.parse(url);
    var response = await http.post(
      uri,
      body: data,
    );
    return response.body;
  }

  Future<String> getRequest({required String url,})async{
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    return response.body;
  }

}
