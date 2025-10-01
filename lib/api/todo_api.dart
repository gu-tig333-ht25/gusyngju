import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/models/todo.dart';

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

  List<ToDo> _processResponse(http.Response response) {
    List<dynamic> jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((todoJson) => ToDo.fromJson(todoJson)).toList();
  }

  Future<List<ToDo>> createToDo(String title) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl/todos?key=$apiKey'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"title": title, "done": false}),
      );
      return _processResponse(response);
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ToDo>> readToDos() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/todos?key=$apiKey'),
      );
      return _processResponse(response);
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ToDo>> updateToDo(ToDo todo) async {
    try {
      http.Response response = await http.put(
        Uri.parse('$baseUrl/todos/${todo.id}?key=$apiKey'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(todo.toJson()),
      );
      return _processResponse(response);
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ToDo>> deleteToDo(String id) async {
    try {
      http.Response response = await http.delete(
        Uri.parse('$baseUrl/todos/$id?key=$apiKey'),
      );
      return _processResponse(response);
    } on Exception catch (e) {
      print(e);
      return [];
    }
  }
}
