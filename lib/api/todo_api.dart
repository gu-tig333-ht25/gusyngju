import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TodoApi {
  String baseUrl = "https://todoapp-api.apps.k8s.gu.se";
  String apiKey;

  TodoApi({required this.apiKey}) {
    if (apiKey.isEmpty) {
      _register().then((key) => {apiKey = key, saveAPIKey()});
    }
  }

  Future<String> _register() async {
    final http.Response response = await http.get(
      Uri.parse("$baseUrl/register"),
    );
    return response.body;
  }

  void saveAPIKey() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("apiKey", apiKey);
  }
}
